dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'active_request')

class Blog < ActiveRequest::Base

  def self.model_name
    "blog"
  end

  attr_accessor :id, :title

  has_many :posts

end
