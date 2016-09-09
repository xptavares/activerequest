module ActiveRequest
  class Base
    include HTTParty
    include HasMany

    base_uri 'localhost:4001'

    def initialize(options)
      options = options.symbolize_keys
      attributes.each do |att|
        send("#{att}=", options[att]) if options[att].present?
      end
    end

    def self.headers
      {
        "uid" => "rddev",
        "customer-token" => "4dba1e34-3241-4c6a-b940-aa3edd7285c6"
      }
    end

    def self.all
      response = get("/v1/#{model_name.pluralize}.json", headers: headers)
      return [] unless 200 == response.code
      body = JSON.parse(response.body)
      body[model_name.pluralize].map { |params| new(params) }
    end

    def self.where(query)
      response = get("/v1/#{model_name.pluralize}.json", query: query, headers: headers)
      return [] unless 200 == response.code
      body = JSON.parse(response.body)
      body[model_name.pluralize].map { |params| new(params) }
    end

    def save
      self.class.post("/v1/#{self.class.model_name.pluralize}.json", query: query, headers: self.class.headers)
    end

    def self.model_name
      raise 'Activerequest::Base#model_name must be implemented by a subclass'
    end

    def self.attr_accessor(*vars)
      @attributes ||= []
      @attributes.concat vars
      super(*vars)
    end

    def self.attributes
      @attributes
    end

    def attributes
      self.class.attributes
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
