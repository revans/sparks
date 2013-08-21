require 'test_helper'
require 'fileutils'

module Sparks
  class EnvTest < Minitest::Test
    ENV_FILE = "./.env"

    def setup
      ::File.open(ENV_FILE, "w+") do |file|
        file.puts <<-CONFIG
RACK_ENV=foobar
PORT=7000
API_KEY=123456
        CONFIG
      end
    end

    def teardown
      ::FileUtils.rm(ENV_FILE)
    end

    def test_loading_env_file
      Env.load(ENV_FILE)
      assert_equal "foobar",  ENV["RACK_ENV"]
      assert_equal "7000",    ENV["PORT"]
      assert_equal "123456",  ENV["API_KEY"]

      assert_equal "foobar",  Sparks.env
    end

    def test_predicate_method_development
      Sparks.env = "development"
      assert Env.development?
      refute Env.test?
      refute Env.staging?
      refute Env.production?
    end

    def test_predicate_method_test
      Sparks.env = "test"
      assert Env.test?
      refute Env.development?
      refute Env.staging?
      refute Env.production?
    end

    def test_predicate_method_staging
      Sparks.env = "staging"
      assert Env.staging?
      refute Env.test?
      refute Env.development?
      refute Env.production?
    end

    def test_predicate_method_production
      Sparks.env = "production"
      assert Env.production?
      refute Env.staging?
      refute Env.test?
      refute Env.development?
    end

  end
end
