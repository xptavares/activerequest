module ActiveRequest
  class Base
    include HTTParty
    include Errors
    include HasMany
    include Attributes
    include Queries

    attr_reader :errors

    def initialize(options = nil)
      if options.present?
        options.symbolize_keys!
        attributes.each do |att|
          send("#{att}=", options[att]) if options[att].present?
        end
      end
      self.class.base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
    end

    def self.model_name
      name.underscore.pluralize
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
