$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_request'

require './../examples/blog.rb'
require './../examples/post.rb'

require 'minitest/autorun'
