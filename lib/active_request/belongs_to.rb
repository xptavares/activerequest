module ActiveRequest
  module HasMany
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end
    module ClassMethods
      def belongs_to(association, options = nil)
        @belongs_tos ||= []
        class_name = !options.nil? && !options[:class_name].nil? ? options[:class_name] : (association.to_s.split.map(&:capitalize)*' ')
        foreign_key = !options.nil? && !options[:foreign_key].nil? ? options[:foreign_key] : "#{association}_id"
        @belongs_tos << { association: association, class_name: class_name, foreign_key: foreign_key }
      end

      def belongs_tos
        @belongs_tos
      end

      def build_belongs_tos(alloc)
        alloc.belongs_tos.each do |many|
          alloc.instance_variable_set("@#{many[:foreign_key]}", nil)
          alloc.instance_variable_set("@#{many[:association]}", nil)
          define_method(many[:association]) do
            variable = alloc.instance_variable_get("@#{many[:association]}")
            if id && variable.blank?
              father_ojb = Object.const_get(many[:class_name])
              variable = father_ojb.find send(many[:foreign_key])
              send("#{many[:association]}=", variable) if variable
            end
            variable
          end
          define_method(many[:foreign_key]) do
            alloc.instance_variable_get("@#{many[:foreign_key]}")
          end
          define_method("#{many[:association]}=") do |association_setter|
            alloc.instance_variable_set("@#{many[:association]}", association_setter)
          end
          define_method("#{many[:foreign_key]}=") do |foreign_key_setter|
            alloc.instance_variable_set("@#{many[:foreign_key]}", foreign_key_setter)
          end
        end if alloc.belongs_tos
      end
    end

    module InstanceMethods
      def belongs_tos
        self.class.belongs_tos
      end
    end
  end
end
