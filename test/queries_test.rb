require 'test_helper'

class QueriestTest < Minitest::Test
  def test_all_
    Blog.all
    refute_nil ::ActiveRequest::VERSION
  end
end
