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

post('/', '/home', '/about') do |params|
  "hoho home : #{params}"
end

pp Raku.mapping

run Raku.new
