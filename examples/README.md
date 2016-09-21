# Examples

## Create Class

```ruby
class Blog < ActiveRequest::Base
  attr_accessor :id, :title
end
```

#### Find All

```ruby
blogs = Blog.all # "GET /v1/blogs.json HTTP/1.1" 200
```

#### Find

```ruby
blog = Blog.find(1) # "GET /v1/blogs/1.json HTTP/1.1" 200
```

#### Where

```ruby
blogs = Blog.where(title: "title 1") # "GET /v1/blogs.json?title=title%201 HTTP/1.1" 200
```

#### Create
```ruby
blog = Blog.new(title: "test") # Blog.new("title" => "test")
blog.save # => true  | "POST /v1/blogs.json?blog[title]=test&blog[posts_attributes][]= HTTP/1.1" 201
```
or
```ruby
blog = Blog.create(title: "Test") # "POST /v1/blogs.json?blog[title]=Test&blog[posts_attributes][]= HTTP/1.1" 201
```

#### Update

```ruby
blog = Blog.find(1)
blog.title = "new title"
blog.save # "PUT /v1/blogs/1.json?blog[id]=1&blog[title]=new%20title&blog[posts_attributes][]= HTTP/1.1" 200
```

#### Delete

```ruby
blog = Blog.find(1)
blog.delete # "DELETE /v1/blogs/1.json HTTP/1.1" 200
```

## Relations

#### classes
```ruby
class Blog < ActiveRequest::Base
  attr_accessor :id, :title
  has_many :posts
end

class Post < ActiveRequest::Base
  attr_accessor :id, :title, :body
  belongs_to :blog
end
```

#### has many

```ruby
blog = Blog.first
=> #<Blog:0x0056334e564ed8 @id=1, @title="title 1", @posts=[]>
blog.posts # "GET /v1/blogs/1/posts.json HTTP/1.1" 200
=> [#<Post:0x0056334e554240 @id=1, @title="title 1", @body="body 1", @blog=nil>, #<Post:0x0056334e5537a0 @id=2, @title="title 2", @body="body 2", @blog=nil>]
```

#### belongs to

```ruby
post = Post.first
post.blog
```
