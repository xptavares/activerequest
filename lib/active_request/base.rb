module ActiveRequest
  class Base
    include HTTParty
    include HasMany
    include Attributes

    def initialize(options)
      options = options.symbolize_keys
      attributes.each do |att|
        send("#{att}=", options[att]) if options[att].present?
      end
      self.class.base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
    end

    def self.headers
      {
        "uid" => ActiveRequest.configuration.uid,
        "customer-token" => ActiveRequest.configuration.customer_token
      }
    end

    def self.all
      base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
      response = get("/#{model_name.pluralize}.json", headers: headers)
      return [] unless 200 == response.code
      body = JSON.parse(response.body)
      body[model_name.pluralize].map { |params| new(params) }
    end

    def self.where(query)
      base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
      response = get("/#{model_name.pluralize}.json", query: query, headers: headers)
      return [] unless 200 == response.code
      body = JSON.parse(response.body)
      body[model_name.pluralize].map { |params| new(params) }
    end

    def self.find(id)
      base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
      response = get("/#{model_name.pluralize}/#{id}.json", headers: headers)
      return [] unless 200 == response.code
      body = JSON.parse(response.body)
      new(body[model_name])
    end

    def save
      self.class.post("/#{self.class.model_name.pluralize}.json", query: query, headers: self.class.headers)
    end

    def self.model_name
      raise 'Activerequest::Base#model_name must be implemented by a subclass'
    end

    private

    def query
      many_atts = query_for_manys.reduce(:merge)
      local_atts = attributes.map { |att| { att => send(att) } }.reduce(:merge)
      { self.class.model_name => local_atts.merge(many_atts) }
    end

    def query_for_manys
      has_manys.map { |many| { "#{many[:association]}_attributes" => send(many[:association]).map { |item| item.attributes.map { |att| { att => item.send(att) } }.reduce(:merge) } } }
    end
  end
end
