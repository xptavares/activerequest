require 'test_helper'

class ModelNameTest < Minitest::Test
  def test_default_name
    assert_equal User.model_name, 'user'
  end

  def test_edit_name
    assert_equal Blog.model_name, 'blog'
  end
end
