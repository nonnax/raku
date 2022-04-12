#!/usr/bin/env ruby
# Id$ nonnax 2022-04-12 11:26:15 +0800
require_relative 'lib/raku'

# you can redefine built-in Rack::Static middleware 
# sample:
# use Rack::Static,
      # urls: %w[/images /js /css],
      # root: 'private'

get('/', '/home', '/about') do |params|
  "hoho home : #{params}"
end

get('/bonkers') do
  res.status=401
  res.write 'Bonkers!'
  halt res.finish
end
get '/red' do
  res.redirect '/bonkers'
  halt res.finish
end

post('/', '/home', '/about') do |params|
  "hoho home : #{params}"
end

pp Raku.mapping

run Raku.new
