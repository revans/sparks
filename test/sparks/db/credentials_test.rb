require 'test_helper'
require "./lib/sparks/db/credentials"

module Sparks::DB
  class CredentialsTest < Minitest::Test
    def options(opts = {})
      {
        user:     'bob',
        password: '123456',
        database: 'maverick'
      }.merge(opts)
    end

    def test_missing_database
      conn = Credentials.new(
        options.merge(database: nil)
      )

      assert NotImplementedError, -> { conn.database }

      conn.database = 'test'
      assert_equal "test", conn.database
    end

    def test_initialization
      conn = Credentials.new(options)
      assert_equal "bob",         conn.user
      assert_equal "123456",      conn.password
      assert_equal "maverick",    conn.database

      assert_equal "localhost",   conn.host
      assert_equal "development", conn.env
      assert_equal "postgres",    conn.adapter
      assert_equal 5432,          conn.port
      assert_equal 5,             conn.pool

      assert_equal "postgres://bob:123456@localhost:5432/maverick",
        conn.adapter_connection
    end

    def test_sqlite_connection
      opts = { adapter: 'sqlite3', max: nil, user: nil, password: nil, host: nil, port: nil, database: 'db/estimate_dev.db', env: 'development' }

      conn = Credentials.new(opts)
      assert_nil conn.user
      assert_nil conn.password

      assert_equal "sqlite://db/estimate_dev.db",
        conn.adapter_connection
    end


    def test_postgres_connection
      opts = {"adapter"=>"postgresql", "encoding"=>"unicode", "database"=>"forum_dev", "pool"=>15, "user"=>"robert", "password"=>nil, "host"=>"localhost", "port"=>1234, "env" => "development"}

      conn = Credentials.new(opts)

      assert_nil conn.password

      assert_equal "robert",      conn.user
      assert_equal "forum_dev",   conn.database
      assert_equal "localhost",   conn.host

      assert_equal "development", conn.env

      assert_equal "postgresql",  conn.adapter
      assert_equal 1234,          conn.port
      assert_equal 15,            conn.pool

      assert_equal "postgres://robert@localhost:1234/forum_dev",
        conn.adapter_connection
    end
  end
end
