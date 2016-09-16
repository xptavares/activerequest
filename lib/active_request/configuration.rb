module ActiveRequest
  class Configuration
    attr_accessor :uri, :headers, :api_version

    def initialize
      @uri = nil
      @headers = nil
      @api_version = nil
    end
  end
end
