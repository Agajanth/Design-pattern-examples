require 'rubygems'
require 'bundler/setup'
require 'json'

Bundler.require(:default)

# The chain of responsability creates a set of objects that are going to process
# something, to do that each object needs two things:
#
# 1. A common interface, so each object has the same method to process the request
# 2. A reference to the next object to pass down the procesed request
#
# The needed interface should define the method names and the expected
# structure of the request
#
# In this example we are going to mimic Rack, the Ruby library that is
# present on every Ruby web framework and has interfaces for a lot of
# Ruby web servers like puma, unicorn, etc.

##
# This is the same app class it is the last class that is going to receive the request
# and has the responsability to provide the ultimate response, there are not more objects
# to call.
class HelloWorld
  ##
  # Returns the formatted response and implementes the standar call interface
  def call(_env)
    [200, { 'Content-Type' => 'text/html' }, ['Hello World']]
  end
end

##
# This Middleware takes an expected text response and wraps html
# around it to give the proper web format.
class HTMLMiddleWare
  ##
  # sets the instance and the Rack app that is going the be called next
  def initialize(app)
    @app = app
  end

  ##
  # Returns the same code and headers but wraps the response body with html
  def call(env)
    resp = @app.call(env)
    [resp[0], resp[1], ["<html>#{resp[2][0]}</html>"]]
  end
end

##
# This middleware is just a logger, it takes the request url and the
# response code and prints it to STDOUT
class PrettyLoggerMiddleWare
  def initialize(app)
    @app = app
  end

  def call(env)
    resp = @app.call(env)
    puts 'x' * 50
    puts "[URL] #{env['PATH_INFO']}"
    puts "[STATUS] #{resp.first}"
    puts 'x' * 50
    resp
  end
end

##
# RackUp groups and sets the objects in order to be procesed, so there is not need
# to be called like:
#
# Rack::Handler::WEBrick.run PrettyLoggerMiddleWare.new(HTMLMiddleWare.new(HelloWorld.new))
class RackUp
  attr_accessor :middlewares

  def initialize(app)
    @middlewares = []
    @app = app
  end

  def use(middleware)
    @middlewares << middleware
  end

  def run
    current = @app
    @middlewares.each do |middleware|
      current = middleware.new(current)
    end
    current
  end
end

rackup = RackUp.new(HelloWorld.new)

rackup.use HTMLMiddleWare
rackup.use PrettyLoggerMiddleWare

# Rack::Handler::WEBrick.run PrettyLoggerMiddleWare.new(HTMLMiddleWare.new(HelloWorld.new))
Rack::Handler::WEBrick.run rackup.run
