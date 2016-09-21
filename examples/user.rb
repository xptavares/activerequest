dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'active_request')

class User < ActiveRequest::Base
  attr_accessor :id, :name
end
