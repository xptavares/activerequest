lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
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
require "faraday"

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
  c.default_cassette_options = { serialize_with: :json }
end

MinitestVcr::Spec.configure!
