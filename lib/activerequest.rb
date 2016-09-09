require "active_request/configuration"
require "active_request/version"
require "active_request/has_many"
require "active_request/attributes"
require "active_request/base"

module ActiveRequest
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
