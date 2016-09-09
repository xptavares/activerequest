module ActiveRequest
  module HasMany
    def self.included(base)
      base.extend(ClassMethods)
      base.send :include, InstanceMethods
    end
    module ClassMethods
      def has_many(association, options)
        @has_manys ||= []
        @has_manys << association
      end

      def has_manys
        @has_manys
      end
    end

    module InstanceMethods
      def has_manys
        self.class.has_manys
      end
    end
  end
end
