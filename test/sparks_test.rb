require 'test_helper'

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
    assert_equal 'development', Sparks.env

    Sparks.env = 'test'
    assert_equal 'test', Sparks.env
  end

  def test_db_confg
    path = mocked_root + "/config/db.yml"
    assert_equal path, Sparks.db_config.to_s
  end

  def test_config
    path = mocked_root + "/config"
    assert_equal path, Sparks.config.to_s
  end
end
