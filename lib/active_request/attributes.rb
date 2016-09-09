module ActiveRequest
  module Attributes
    def self.included(base)
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
    end
    module ClassMethods
      def attr_accessor(*vars)
        @attributes ||= []
        @attributes.concat vars
        super(*vars)
      end

      def attributes
        @attributes
      end
    end

    module InstanceMethods
      def attributes
        self.class.attributes
      end
    end
  end
end
