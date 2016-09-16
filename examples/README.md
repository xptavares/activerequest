# Examples


```ruby
b = Blog.new(title: "test") # Blog.new("title" => "test")
b.save # => true  | 127.0.0.1 - - [16/Sep/2016:10:34:10 -0300] "POST /v1/blogs.json?blog[title]=test&blog[posts_attributes][]= HTTP/1.1" 201 20 0.0007
```
