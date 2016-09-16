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
        @belongs_tos << { association: association, class_name: class_name }
        # define_method("#{association}=") do |association|
        #   set(association)
        # end
      end

      def belongs_tos
        @belongs_tos
      end

      def build_belongs_tos(alloc)
        alloc.belongs_tos.each do |many|
          alloc.instance_variable_set("@#{many[:association]}", nil)
          define_method(many[:association]) do
            alloc.instance_variable_get("@#{many[:association]}")
          end
          define_method("#{many[:association]}=") do |many_setter|
            alloc.instance_variable_set("@#{many[:association]}", many_setter)
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
