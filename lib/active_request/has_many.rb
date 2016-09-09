module ActiveRequest
  module HasMany
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end
    module ClassMethods
      def has_many(association, options)
        @has_manys ||= []
        @has_manys << { association: association, class_name: options[:class_name] }
        # define_method("#{association}=") do |association|
        #   set(association)
        # end
      end

      def has_manys
        @has_manys
      end

      def new( *args, &blk )
         o = allocate
         o.instance_eval{initialize( *args, &blk )}
         o.has_manys.each do |many|
           o.instance_variable_set("@#{many[:association]}", [])
           define_method(many[:association]) do
             o.instance_variable_get("@#{many[:association]}")
           end
           define_method("#{many[:association]}=") do |many_setter|
             o.instance_variable_set("@#{many[:association]}", many_setter)
           end
         end if o.has_manys
         o
      end
    end

    module InstanceMethods
      def has_manys
        self.class.has_manys
      end
    end
  end
end
