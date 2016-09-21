require 'test_helper'

class HasManyTest < Minitest::Test
  def test_find_by_association
    VCR.use_cassette('find_blog_and_posts') do
      blog = Blog.find 1
      refute_nil blog
      assert_equal blog.posts.count, 2
      refute_nil blog.posts.first.blog
      assert_equal blog, blog.posts.first.blog
    end
  end
end
