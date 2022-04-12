#!/usr/bin/env ruby
# Id$ nonnax 2022-04-12 11:22:22 +0800
# raku : as cute as possible :> rack router
require 'forwardable'
D=Object.method(:define_method)
module Raku  
  extend Forwardable
  def_delegators :stack, :map, :use
  handlers, maps=nil,nil
  D.(:mapping){ maps ||= Hash[] }
  D.(:handle){ |status, &block| handler[status]=block }
  D.(:handler){ handlers ||= Hash.new{|h,k| h[k]=->(){} }}
  %w(GET POST PUT DELETE).map do |m| D.(m.downcase){ |*u, &block| u.flatten.map{|x| mapping[[m, x]]=block } } end
  def self.new() stack.run App.new end
  def self.stack() @stack ||= Rack::Builder.new{ use Rack::Static, urls: %w[/images /js /css], root: 'public' } end
  class App
    attr :res, :req, :env
    def _call(env)
      catch(:halt) {
        @req, @res, @env=Rack::Request.new(env), Rack::Response.new, env
        res.write(body=instance_exec(
          req.params.transform_keys(&:to_sym), &::Raku.mapping[env.values_at('REQUEST_METHOD', 'PATH_INFO')]) rescue nil )
        body ? res.finish : not_found 
      }
    end
    def call(env) dup._call(env) end
    def not_found() instance_eval(&Raku::handler[404]) rescue [404, {}, ['Not Found']] end
    def halt(res) throw :halt, res end      # bypass
  end
end
