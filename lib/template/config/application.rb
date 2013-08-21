$stdout.sync = true

# can require framework things here
# sprockets here?
module Microsites
  class App < Sinatra::Base

    # general default configuration
    configure do
      set :public_folder,     "./public"
      set :views,             "./app/views"
      set :show_exceptions,   false
      # set :server,            'thin'
      set :connections,       []

      # mime_type :plain, 'text/plain'
      # enable :sessions
    end

    # Error Handling
    not_found do
      # do something, return a 404 page
    end

    # connection to sql
    # DB, Sequel::Model.db = PatriotNetwork.db_connect!

    # Sequel Extensions
    # Sequel.extension :migration, :core_extensions

    # require application files
    # PatriotNetwork.load!

  end
end

## Application.rb
#
# This should be totally configurable to set your application and directory
# structure to best reflect the domain of the application in which you are
# building.
#
## Necessary
#
# Include Rack Security apps
# Include Rack Caching
#
## Optional
#
# Include Rack CoffeeScript
# Include Rack Sass

## For this app, this is how I'll set it up
#
# load files
# Dir.glob('./app/{routes,models}/*.rb').each { |file| require file }

# Load an environment and include the environments setttings.
# We should allow sharing of settings between all environments.
#
# if production
#   require 'rack/cache'
#   use Rack::Cache
# elsif test
# else
#  auto-reload with shotgun or something
#  no caching
# end

# Setup database if there is one