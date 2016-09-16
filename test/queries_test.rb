require 'test_helper'

class QueriestTest < Minitest::Test
  def test_should_has_two_blogs
    VCR.use_cassette('all_blogs') do
      assert_equal Blog.all.count, 2
    end
  end

  def test_should_fill_id_after_create
    VCR.use_cassette('post_to_blogs') do
      blog = Blog.new title: "Test"
      assert_equal blog.save, true
      refute_nil blog.id
    end
  end

  def test_shouldnt_update_id_after_update_model
    VCR.use_cassette('test_shouldnt_update_id_after_update_model') do
      blog = Blog.first
      string_to_udpate_title = "Update"
      blog.title = string_to_udpate_title
      id = blog.id
      assert_equal blog.save, true
      assert_equal blog.id, id
      assert_equal blog.title, string_to_udpate_title
    end
  end
end
