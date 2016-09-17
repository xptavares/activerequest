#!/usr/bin/env ruby
require 'rubygems'
require "sinatra"
require "sinatra/json"

get '/' do
  json foo: 'bar'
end

get '/v1/blogs.json' do
  b1 = { id: 1, title: 'title 1' }
  b2 = { id: 2, title: 'title 2' }
  blogs = [b1, b2]
  blogs = blogs.select { |b| b[:id].to_s == params[:id] } if params[:id]
  blogs = blogs.select { |b| b[:title] == params[:title] } if params[:title]
  json blogs: blogs
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

delete '/v1/blogs/:id.json' do
  id = params[:id]
  json blog: { id: id.to_i }
end

get '/v1/posts.json' do
  t1 = { id: 1, title: 'title 1', body: 'body 1', blog_id: 1 }
  t2 = { id: 2, title: 'title 2', body: 'body 2', blog_id: 1 }
  t3 = { id: 3, title: 'title 3', body: 'body 3', blog_id: 2 }
  posts = [t1, t2, t3]
  posts = posts.select { |b| b[:id].to_s == params[:id] } if params[:id]
  posts = posts.select { |b| b[:title] == params[:title] } if params[:title]
  posts = posts.select { |b| b[:body] == params[:body] } if params[:body]
  json posts: posts
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
