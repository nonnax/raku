#!/usr/bin/env ruby
# Id$ nonnax 2022-04-12 11:22:22 +0800
# raku : as cute as possible :> rack router
D=Object.method(:define_method)
module Raku  
  maps ||= Hash[]
  D.(:mapping){ maps }
  %w(GET POST PUT DELETE).map do |m| D.(m.downcase){ |*u, &block| u.flatten.each{|x| maps[[m, x]]=block } } end
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
      catch(:halt) {
        @req, @res, @nv=Rack::Request.new(env), Rack::Response.new, env
        res.write(body=instance_exec(req.params, &::Raku.mapping[env.values_at('REQUEST_METHOD', 'PATH_INFO')]) rescue nil)
        body ? res.finish : not_found
      }
    end
    def not_found() [404, {}, ['Not Found']] end
    def halt(res) throw :halt, res end      # bypass
  end
end
