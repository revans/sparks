require 'logger'

module Sparks
  module DB
    class Credentials
      attr_accessor :user, :password, :database
      attr_writer   :host, :port, :env, :pool, :adapter, :encoding

      # Class Method for class level connection to the database. Options are the same
      # as the initializer.
      #
      def self.connect!(options = {})
        new(options).connect
      end

      def self.connection(options = {})
        new(options)
      end

      # Takes an options hash that will then set the accessors for interacting with the database
      #
      # ==== Attributes
      #
      #   * +options+ - A Hash of options, which are:
      #       +user+        - The username to connect to the database
      #       +password+    - The password used to connect to the database
      #       +database+    - The name of the database in which to connect to
      #       +host+        - The host of where the database is located
      #       +port+        - The port of the database to use
      #       +env+         - Which environment to run the connection under
      #       +pool+        - Number of connections to the database
      #       +adapter+     - The database name that will be used e.g. postgres, sqlite, mysql
      #       +encoding+    - The encoding being used e.g. utf-8
      #
      def initialize(options = {})
        options.each { |k,v| instance_variable_set("@#{k}", v) }
      end

      # A Reader for the host that will be used to connect to the database
      #
      def host
        @host || 'localhost'
      end

      # A Reader for the port that will be used to connect to the database
      #
      def port
        @port || 5432
      end

      # A Reader for the environment in which the database will run under.
      # Depending on the developer settings within their db.yml, it can be set
      # to use different databases based on environments.
      #
      def env
        @env || 'development'
      end

      # A Reader for the number of connections to the database
      #
      def pool
        @pool || 5
      end

      # A Reader for the database adapter being used
      #
      def adapter
        @adapter || "postgres"
      end

      # A Reader for the database encoding being used
      #
      def encoding
        @encoding || 'utf8'
      end

      # Adapter Connection String
      #
      # Returns a String of the attributes needed to connect to the specified database
      #
      def adapter_connection
        "#{formatted_adapter}://#{login_host}#{format_database_for_adapter}"
      end

      # Sets the logger and log file that will be used for the database logging
      #
      def logger
        make_log_directory
        ::Logger.new("log/#{env}_db.log")
      end

      # Connects to the database
      #
      # TODO: Need to add pool/max_connections and logger
      def connect
        ::Sequel.connect(adapter_connection, {
          logger:           logger,
          max_connections:  pool
        })
      end

      private

      # Joins the username, password, host and port if they have been given by the developer.
      #
      # Returns a String or Nil
      #
      def login_host
        con = "#{login}@#{host}"  if login && host
        con << ":#{port}"         if con && port
        con
      end

      # Joins the username and password for database access if they exist.
      #
      # Returns a string or Nil
      #
      def login
        @login ||= begin
          login = user            if user
          login << ":#{password}" if password
          login
        end
      end

      # Formatting the name of the adapter set by the developer. Rails allows the developer
      # to set postgres to postgresql, but when establishing the connection with Sequel, 'postgres'
      # adapter name is required.
      #
      # Returns a String
      #
      def formatted_adapter
        case adapter
        when 'postgresql' then 'postgres'
        when 'sqlite3'    then 'sqlite'
        else
          adapter
        end
      end

      # Setting up the database or database path. Specifically needed for setting up
      # the sqlite database where we need to return a path to the database and not
      # just the name of the database.
      #
      # Returns a String
      #
      def format_database_for_adapter
        @db ||= if adapter == 'sqlite3'
          # database_path(database)
          database
        else
          "/#{database}"
        end
      end

      # Makes the log directory if it does not exist
      #
      def make_log_directory
        ::FileUtils.mkdir("log") unless File.exists?("log")
      end

    end
  end
end
