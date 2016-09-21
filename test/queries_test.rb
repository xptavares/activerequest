require 'test_helper'

class QueriestTest < Minitest::Test
  def test_should_has_two_blogs
    VCR.use_cassette('all_blogs') do
      assert_equal Blog.all.count, 2
    end
  end

  def test_should_get_first
    VCR.use_cassette('all_blogs') do
      blog = Blog.first
      refute_nil blog.id
    end
  end

  def test_should_get_last
    VCR.use_cassette('all_blogs') do
      blog = Blog.last
      refute_nil blog.id
    end
  end

  def test_should_fill_id_after_create
    VCR.use_cassette('post_to_blogs') do
      blog = Blog.new title: "Test"
      assert_equal blog.save, true
      refute_nil blog.id
    end
  end

  def test_erro_on_create_blog
    VCR.use_cassette('test_erro_on_create_blog') do
      blog = Blog.new
      assert_equal blog.save, false
      assert_equal blog.id, nil
      assert_equal blog.errors, "title" => ["obrigatório"]
    end
  end

  def test_erro_on_update_blog
    VCR.use_cassette('test_erro_on_update_blog') do
      blog = Blog.find 1
      blog.title = nil
      assert_equal blog.save, false
      assert_equal blog.id, 1
      assert_equal blog.errors, "title" => ["obrigatório"]
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

  def test_should_find_by_model_pk
    VCR.use_cassette('test_should_find_by_model_pk') do
      blog = Blog.new title: "Test"
      assert_equal blog.save, true
      refute_nil blog.id
      blog_findd = Blog.find blog.id
      assert_equal blog.id, blog_findd.id
    end
  end

  def test_create_class_method
    VCR.use_cassette('test_create_class_method') do
      blog = Blog.create title: "Test"
      refute_nil blog.id
      assert_equal blog.title, "Test"
    end
  end

  def test_find_and_delete_blog
    VCR.use_cassette('test_find_and_delete_blog') do
      blog = Blog.find 1
      refute_nil blog.id
      assert_equal blog.delete, true
    end
  end

  def test_get_blogs_by_title
    VCR.use_cassette('test_get_blogs_by_title') do
      blogs = Blog.where(title: 'title 1')
      assert_equal blogs.count, 1
    end
  end
end
