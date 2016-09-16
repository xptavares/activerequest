dir = File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require File.join(dir, 'active_request')

class Post < ActiveRequest::Base

  def self.model_name
    "post"
  end

  attr_accessor :id, :title, :body

  belongs_to :blog

end
