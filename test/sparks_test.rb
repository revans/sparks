require 'test_helper'

def set_env_to(env)
  ENV['RACK_ENV'] = env
end

class SparksTest < Minitest::Test
  def mocked_root
    ::File.expand_path("../../", __dir__)
  end

  def app_logic
    mocked_root + "/app/**/**/*.rb"
  end

  def test_root
    assert_equal mocked_root,
      Sparks.root.to_s
  end

  def test_app_logic
    assert_equal app_logic,
      Sparks.app_logic.to_s
  end

  def test_rake_tasks
    path = mocked_root + "/lib/tasks/**/*.rake"
    assert_equal path,
      Sparks.rake_tasks.to_s
  end

  def test_load
    assert Sparks.load!
  end

  def test_reload
    assert Sparks.reload!
  end

  def test_env
    set_env_to "development"
    assert_equal 'development', Sparks.env

    Sparks.env = 'test'
    assert_equal 'test', Sparks.env
  end

  def test_database_config
    path = mocked_root + "/config/db.yml"
    assert_equal path, Sparks.database_config.to_s
  end

  def test_config
    path = mocked_root + "/config"
    assert_equal path, Sparks.config_path.to_s
  end

  def test_public_file
    path = mocked_root + "/public"
    assert_equal path, Sparks.public_file
  end

  def test_public_path
    path = mocked_root + "/public"
    assert_equal path, Sparks.public_path.to_s
  end

  def test_view_files
    path = mocked_root + "/app/views"
    assert_equal path, Sparks.view_files
  end

  def test_view_path
    path = mocked_root + "/app/views"
    assert_equal path, Sparks.view_path.to_s
  end

  def test_build
    dirs = Sparks.build

    assert_match "app/api.rb",      dirs.first
    assert_match "app/**/**/*.rb",  dirs.last
  end
end
