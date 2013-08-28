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

# Include the Rack Test Methods within
# Minitest.
class Minitest::Test
  include Rack::Test::Methods
end
