require 'test_helper'

class BelongsToTest < Minitest::Test
  def test_find_by_title
    VCR.use_cassette('find_by_title') do
      blog = Blog.find_by_title "title 1"
      refute_nil blog.id
    end
  end

  def test_find_by
    VCR.use_cassette('find_by_title') do
      blog = Blog.find_by title: "title 1"
      refute_nil blog.id
    end
  end

  def test_methods_include_find_by_title
    assert_includes Blog.methods, :find_by_title
  end

  def test_methods_include_find_by
    assert_includes Blog.methods, :find_by
  end
end
