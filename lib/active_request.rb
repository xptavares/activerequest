require 'active_support/inflector'
require 'active_support/core_ext/hash'
require 'httparty'

require "active_request/configuration"
require "active_request/version"
require "active_request/errors"
require "active_request/queries"
require "active_request/belongs_to"
require "active_request/has_many"
require "active_request/find_by"
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
