#!/usr/bin/env ruby
# Id$ nonnax 2022-04-12 11:26:15 +0800
require_relative 'lib/raku'

# you can redefine built-in Rack::Static middleware 
# sample:
# use Rack::Static,
      # urls: %w[/images /js /css],
      # root: 'private'
handle 404 do
  halt [404, {}, ['Whoa! Bonkers!']]
end

get('/', '/home', '/about') do |params|
  "hoho home : #{params}"
end

get('/bonkers') do
  halt [401, {}, ['Bonkers!']]
end

get '/red' do
  res.redirect '/bonkers'
end

post('/', '/home', '/about') do |params|
  "hoho home : #{params}"
end

# anonymous apps are welcome :>
map('/inner'){ run ->(env){[200, {}, ['Inner space!']]}}

pp Raku.mapping

run Raku.new
