require 'test_helper'

def set_env_to(env)
  ENV['RACK_ENV'] = env
end

def set_root_to(path)
  ENV["SPARKS_ROOT"] = path
end

class SparksTest < Minitest::Test
  def setup
    set_root_to(::Pathname.new(__dir__).expand_path.to_s)
  end

  def mocked_root(arg = '')
    ::Pathname.new(__dir__).expand_path.join(arg).to_s
  end

  def app_logic
    mocked_root("apps/**/**/*.rb")
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

  def test_build
    dirs = Sparks.build

    # assert_match "app/api.rb",      dirs.first
    assert_match "apps/**/**/*.rb",  dirs.last
  end

  def test_assets_path
    path = mocked_root + "/assets"
    assert_equal path, Sparks.assets_path.to_s
  end

  def test_vendor_assets_path
    path = mocked_root + "/vendor/assets"
    assert_equal path, Sparks.vendor_assets_path.to_s
  end
end
