module ActiveRequest
  module FindBy
    def self.included(base)
      base.extend(ClassMethods)
    end
    module ClassMethods

      def find_by(query)
        where(query).first
      end

      def build_find_by
        attributes.each do |attribute|
          define_singleton_method("find_by_#{attribute}") do |param|
            find_by(attribute => param)
          end
        end
      end
    end
  end
end
