module ActiveRequest
  module HasMany
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end
    module ClassMethods
      def has_many(association, options = nil)
        @has_manys ||= []
        class_name = !options.nil? && !options[:class_name].nil? ? options[:class_name] : (association.to_s.split.map(&:capitalize)*' ').singularize
        @has_manys << { association: association, class_name: class_name }
      end

      def has_manys
        @has_manys
      end

      def build_has_manys(alloc)
        alloc.has_manys.each do |many|
          alloc.instance_variable_set("@#{many[:association]}", [])
          define_method(many[:association]) do
            variable = alloc.instance_variable_get("@#{many[:association]}")
            if id && variable.blank?
              father_ojb = Object.const_get(many[:class_name])
              father_model_name = father_ojb.model_name.pluralize
              self_model_name = self.class.model_name
              self.class.base_uri("#{ActiveRequest.configuration.uri}/#{ActiveRequest.configuration.api_version}/")
              response = self.class.get("/#{self_model_name.pluralize}/#{id}/#{father_model_name}.json", headers: self.class.headers)
              return [] unless 200 == response.code
              body = JSON.parse(response.body)
              # TODO era para ser assim mesmo?
              childrens = body["#{self_model_name}/#{father_model_name}"].map { |params| father_ojb.new(params) }
              childrens.each do |ch|
                ch.instance_variable_set("@#{self_model_name}", self)
                ch.instance_variable_set("@#{self_model_name}_id", self.id)
              end
              send("#{many[:association]}=", childrens)
              variable = childrens
            end
            variable
          end
          define_method("#{many[:association]}=") do |many_setter|
            alloc.instance_variable_set("@#{many[:association]}", many_setter)
          end
        end if alloc.has_manys
      end
    end

    module InstanceMethods
      def has_manys
        self.class.has_manys
      end
    end
  end
end
