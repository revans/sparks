# set the environment
ENV['RACK_ENV'] = 'test'

# Load Bundler and Gemfile with the "test" env
require 'bundler'
Bundler.require(:default, ENV["RACK_ENV"])

# explicitly require testing frameworks
require 'minitest/autorun'
require 'minitest/pride'
require 'rack/test'

# Application Configuration
require "./config/application"

# Applications
require "./apps/api"

module BuilderDsl
  def route_to(url, app)
    map(url) { run app.new }
  end
end

class Rack::Builder
  include BuilderDsl
end

module BuilderHelper
  include BuilderDsl

  def builder(&block)
    build = ::Rack::Builder.new
    build.instance_eval(&block)
    build.to_app
  end
end

# Include the Rack Test Methods within
# Minitest.
class Minitest::Test
  include Rack::Test::Methods
end

# When testing Sinatra apps, you'll need to
# setup an +app+ method. There's a couple
# of convenient methods for doing so. Here's
# and example:

# module MySinatraApplication
#   class ApiTest < Minitest::Test
#     include BuilderHelper
#
#     def app
#       builder do
#         route_to "/api/v1", Api
#       end
#     end
#   end
# end

# The +app+ method above is the equivelant of doing:

# module MySinatraApplication
#   class ApiTest < Minitest::Test
#     def app
#       ::Rack::Builder.new do
#         map "/api/v1" do
#           run Api.new
#         end
#       end.to_app
#     end
#   end
# end
