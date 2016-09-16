#!/usr/bin/env ruby
require 'rubygems'
require "sinatra"
require "sinatra/json"

get '/' do
  json foo: 'bar'
end

get '/v1/blogs.json' do
  json blogs: [{ id: 1, title: 'title 1' }, { id: 2, title: 'title 2' }]
end

get '/v1/blogs/:id.json' do
  id = params[:id]
  json blog: { id: id.to_i, title: "title #{id}" }
end

post '/v1/blogs.json' do
  status 201
  json blog: { id: rand(1..9999) }
end

put '/v1/blogs/:id.json' do
  id = params[:id]
  json blog: { id: id.to_i }
end

get '/v1/posts.json' do
  json posts: [{ id: 1, title: 'title 1', body: 'body 1', blog_id: 1 }, { id: 2, title: 'title 2', body: 'body 2', blog_id: 1 }, { id: 2, title: 'title 2', body: 'body 3', blog_id: 2 }]
end


get '/v1/posts/:id.json' do
  id = params[:id]
  json post: { id: id.to_i, title: "title #{id}", body: "body #{id}", blog_id: id.to_i }
end

post '/v1/posts.json' do
  status 201
  json post: { id: rand(1..9999) }
end

put '/v1/posts/:id.json' do
  id = params[:id]
  json post: { id: id.to_i }
end
