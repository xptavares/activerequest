module ActiveRequest
  class Configuration
    attr_accessor :uri, :uid, :customer_token

    def initialize
      @uri = nil
      @uid = nil
      @customer_token = nil
    end
  end
end
