#!/usr/bin/env ruby
# Id$ nonnax 2022-04-12 11:22:22 +0800
# raku : as cute as possible :> rack router
D=Object.method(:define_method)
module Raku  
  maps ||= Hash[]
  D.(:mapping){ maps }
  %i(GET POST PUT DELETE).map do |m|
      D.(m.downcase){ |*u, &block| u.flatten.each{|x| maps[[m, x]]=block } }
  end
  def self.call(env) @app.call(env)  end
  def self.new
    @app=Rack::Builder.new do
      use Rack::Static, urls: %w[/images /js /css], root: 'public'      
      run App.new
    end
  end
  class App
    attr :res, :req, :env
    def call(env)
      @req, @res, @nv=Rack::Request.new(env), Rack::Response.new, env
      body=instance_exec(req.params,  &::Raku.mapping[env.values_at('REQUEST_METHOD', 'PATH_INFO')]) rescue nil
      return [200, {}, [body]] if body
      not_found
    end
    def not_found
      [404, {}, ['Not Found']]
    end
  end
end
