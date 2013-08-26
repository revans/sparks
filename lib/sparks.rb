require 'pathname'
require 'json'
require 'yaml'

require_relative "sparks/env"
require_relative "sparks/db/credentials"
require_relative "sparks/generators"
require_relative "sparks/version"

## TODO: Possibly add these:
#
# Include Rack Security apps
# Include Rack Caching
#
# Include Rack CoffeeScript
# Include Rack Sass

module Sparks
  extend self

  # ENV reader
  #
  def env
    ENV['RACK_ENV'] ||= 'development'
  end

  # ENV writer
  #
  def env=(val = 'development')
    ENV['RACK_ENV'] = val
  end

  # Returns the path to the root directory
  #
  def root
    ::Pathname.new(__dir__).join("../..").expand_path
  end

  # Path to where the application logic exists
  #
  def app_path
    root.join("apps")
  end

  # Returns the path to the public folder
  #
  def public_file
    public_path.to_s
  end

  # Returns the path to the view files
  #
  def view_files
    view_path.to_s
  end

  # Public Path
  #
  def public_path
    root.join("public")
  end

  # View Path
  #
  def view_path
    app_path.join("views")
  end

  # Returns an array to all the application logic files (user created)
  #
  # ==== Example
  #
  #   When creating a new applicaton with the Sparks Framework,
  #   you can create whatever directories make sense. The only requirement
  #   for that is that those files live within the app/ directory.
  #
  def app_logic
    # root.join("app/**/**/*.rb")
    app_path.join("**/**/*.rb")
  end

  # Returns an array to all the rake tasks (user created)
  #
  def rake_tasks
    root.join("lib/tasks/**/*.rake")
  end

  # Location to the config directory
  #
  def config_path
    root.join('config')
  end

  # Returns the path to the database configuration file.
  #
  # ==== Returns
  #
  #   * String
  #
  def database_config
    config_path.join("db.yml")
  end

  # Path to the user set assets
  #
  def assets_path
    app_path.join("assets")
  end

  # Path to the vendored 3rd party assets
  #
  def vendor_assets_path
    root.join("vendor/assets")
  end

  # Loads all the application files
  #
  # - aliased to #reload!
  #
  def load!
    ::Dir.glob(build).each { |file| require file }
  end
  alias :reload! :load!

  # Reads the database settings file
  #
  # ==== Returns
  #
  #   * Hash
  #
  def read_db_yaml_file
    ::YAML.load(db_config.read)
  end

  # Load the Database config for the current
  # environment.
  #
  def load_database_config
    read_db_yaml_file[Sparks.env]
  end

  # Builds an array of the files that will be loaded
  #
  # ==== Returns
  #
  #   * Array
  #
  def build
    [
      # root.join("app/api.rb").to_s,
      # root.join("apps/apps.rb").to_s,
      app_logic.to_s
    ]
  end
end


# What do I want the directory structure to look like
# for multiple apps?
#
# apps/apps.rb
# apps/api/app.rb
# apps/api/views
# apps/registration/app.rb
# apps/registration/views
