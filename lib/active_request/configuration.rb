module ActiveRequest
  class Configuration
    attr_accessor :uri, :uid, :customer_token, :api_version

    def initialize
      @uri = nil
      @uid = nil
      @customer_token = nil
      @api_version = nil
    end
  end
end
