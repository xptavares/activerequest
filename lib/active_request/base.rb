module ActiveRequest
  class Base
    include HTTParty
    include Errors
    include HasMany
    include FindBy
    include Attributes
    include Queries

    attr_reader :errors

    def initialize(options = nil)
      if options.present?
        options.symbolize_keys!
        attributes.each do |att|
          send("#{att}=", options[att]) if options[att].present?
        end
        belongs_tos.each do |att|
          simble = att[:foreign_key].to_sym
          send("#{att[:foreign_key]}=", options[simble]) if options[simble].present?
        end if belongs_tos
      end
      self.class.base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
    end

    def self.model_name
      name.underscore
    end

    def self.new(*args, &blk)
      alloc = allocate
      build_has_manys(alloc)
      build_belongs_tos(alloc)
      alloc.instance_eval { initialize(*args, &blk) }
      alloc
    end
  end
end
