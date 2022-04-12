# raku 

<:as-cute-as-possible>~ rack router

## example:

require 'raku'

built-in Rack::Static middlewares can be redefined with ```use```:  

    # use Rack::Static,
    #  urls: %w[/images /js /css],
    #  root: 'private'
          
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

define status handlers with ```handle```

    handle 404 do
      halt [404, {}, ['Whoa! Bonkers!']]
    end

define anonymous apps with ```map```

    map('/inner'){ run ->(env){[200, {}, ['Inner space!']]}}

    pp Raku.mapping

    run Raku.new
    
    :>
