require 'pathname'
require 'json'
require 'yaml'

require_relative "sparks/env"
require_relative "sparks/db/credentials"
require_relative "sparks/generators"

module Sparks
  extend self

  def env
    ENV['RACK_ENV'] ||= 'development'
  end

  def env=(val = 'development')
    ENV['RACK_ENV'] = val
  end

  # Returns the path to the root directory
  #
  def root
    ::Pathname.new(__dir__).join("../..").expand_path
  end

  # Returns the path to the public folder
  #
  # NOTE: should deprecate this in favor of the developer
  #       setting this themselves
  #
  def public_file
    root.join("public").to_s
  end

  # Returns the path to the view files
  #
  # NOTE: should deprecate this in favor of the developer
  #       setting this themselves
  #
  def view_files
    root.join("app/views").to_s
  end

  # Returns an array to all the application logic files (user created)
  #
  # ==== Example
  #
  #   When creating a new applicaton with the PatriotNetwork Framework,
  #   you can create whatever directories make sense. The only requirement
  #   for that is that those files live within the app/ directory.
  #
  def app_logic
    root.join("app/**/**/*.rb")
  end

  # Returns an array to all the rake tasks (user created)
  #
  def rake_tasks
    root.join("lib/tasks/**/*.rake")
  end

  # Location to the config directory
  #
  def config
    root.join('config')
  end

  # Database Yaml Configuration file
  #
  def db_config
    root.join('config/db.yml')
  end

  # Returns the path to the database configuration file. Specifically
  # being used for setting up the connection to sqlite3
  #
  # Returns a String
  #
  # ==== Attributes
  #
  #   * +db_file+ - The name of the database specified by the developer.
  #
  def database_path(db_file)
      # config.
      # join(db_file).
      db_config.
      expand_path.
      to_s.
      sub(/^\//, '')
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

  # Builds an array of the files that will be loaded
  #
  # ==== Returns
  #
  #   * Array
  #
  def build
    [
      root.join("app/app.rb").to_s,
      app_logic.to_s
    ]
  end
end
