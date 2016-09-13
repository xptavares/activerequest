module ActiveRequest
  class Base
    include HTTParty
    include Errors
    include HasMany
    include Attributes
    include Queries

    attr_reader :errors

    def initialize(options)
      options = options.symbolize_keys
      attributes.each do |att|
        send("#{att}=", options[att]) if options[att].present?
      end
      self.class.base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
    end

    def self.model_name
      raise 'Activerequest::Base#model_name must be implemented by a subclass'
    end

    def self.new( *args, &blk )
      alloc = allocate
      alloc.instance_eval { initialize(*args, &blk) }
      build_has_manys(alloc)
      build_belongs_tos(alloc)
      alloc
    end
  end
end
