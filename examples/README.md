# Examples

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
