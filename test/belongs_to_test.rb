require 'test_helper'

class BelongsToTest < Minitest::Test
  def test_find_by_association
    VCR.use_cassette('find_first_and_blog') do
      post = Post.find 1
      refute_nil post.blog
      refute_nil post.blog_id
    end
  end
end
