lib = File.expand_path('../../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_request'

require './examples/blog.rb'
require './examples/post.rb'
require './examples/config.rb'

require 'minitest/autorun'
