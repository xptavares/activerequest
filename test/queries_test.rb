require 'test_helper'

class QueriestTest < Minitest::Test
  def test_should_has_two_blogs
    assert_equal Blog.all.count, 2
  end

  def test_should_fill_id_after_create
    blog = Blog.new title: "Test"
    assert_equal blog.save, true
    refute_nil blog.id
  end

  def test_shouldnt_update_id_after_update_model
    blog = Blog.first
    string_to_udpate_title = "Update"
    blog.title = string_to_udpate_title
    id = blog.id
    assert_equal blog.save, true
    assert_equal blog.id, id
    assert_equal blog.title, string_to_udpate_title
  end
end
