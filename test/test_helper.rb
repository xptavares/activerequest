require 'rubygems'

if ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start

  require 'codecov'
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require 'active_request'

require './examples/blog.rb'
require './examples/post.rb'
require './examples/config.rb'

require 'minitest/autorun'
require "minispec-metadata"
require "vcr"
require "minitest-vcr"
require "webmock"
require "mocha/setup"
require "multi_json"

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { serialize_with: :json, record: :once }
  c.allow_http_connections_when_no_cassette = false
  c.ignore_localhost = false
  c.ignore_hosts 'codeclimate.com'
end

MinitestVcr::Spec.configure!
