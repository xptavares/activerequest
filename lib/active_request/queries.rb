module ActiveRequest
  module Queries
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end
    module ClassMethods
      def headers
        {
          "uid" => ActiveRequest.configuration.uid,
          "customer-token" => ActiveRequest.configuration.customer_token
        }
      end

      def all
        base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
        response = get("/#{model_name.pluralize}.json", headers: headers)
        return [] unless 200 == response.code
        body = JSON.parse(response.body)
        body[model_name.pluralize].map { |params| new(params) }
      end

      def where(query)
        base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
        response = get("/#{model_name.pluralize}.json", query: query, headers: headers)
        return [] unless 200 == response.code
        body = JSON.parse(response.body)
        body[model_name.pluralize].map { |params| new(params) }
      end

      def find(id)
        base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
        response = get("/#{model_name.pluralize}/#{id}.json", headers: headers)
        return [] unless 200 == response.code
        body = JSON.parse(response.body)
        new(body[model_name])
      end
    end

    module InstanceMethods
      def save
        instance_variable_set("@errors", [])
        response = self.class.post("/#{self.class.model_name.pluralize}.json", query: query, headers: self.class.headers)
        unless 201 == response.code
          instance_variable_set("@errors", response["errors"])
          return false
        end
        body = JSON.parse(response.body)
        instance_variable_set("@id", body[self.class.model_name]["id"])
        true
      end

      private

      def query
        many_atts = query_for_manys.reduce(:merge)
        attributes.each { |att| puts send(att) if att == :id }
        local_atts = attributes.map { |att|  add_key_value(att, send(att)) }.reject(&:blank?).reduce(:merge)
        { self.class.model_name => local_atts.merge(many_atts) }
      end

      def query_for_manys
        has_manys.map { |many| { "#{Object.const_get(many[:class_name]).model_name.pluralize}_attributes" => send(many[:association]).map { |item| item.attributes.map { |att| add_key_value(att, item.send(att)) }.reject(&:blank?).reduce(:merge) } } }
      end

      def add_key_value(key, value)
        { key => value } if value
      end
    end
  end
end
