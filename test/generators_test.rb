require "test_helper"
require "./lib/sparks"
require 'tmpdir'

class GeneratorsTest < Minitest::Test
  def temp(&block)
    appname = 'zues'
    Dir.mktmpdir do |tmp|
      gen = Sparks::Generators.new("./test/#{appname}")
      yield(gen) if block_given?
    end
  end

  def exists?(file)
    File.exists?(file) || File.directory?(file)
  end

  def teardown
    ::FileUtils.rm_rf "./test/zues"
  end

  def test_app_generation
    expected_app_path       = 'zues'
    expected_template_path  = "lib/generators/template"

    temp do |generator|

      assert_match expected_app_path, generator.app_root.to_s
      assert_match expected_template_path, generator.template_root.to_s

      # assert gen.build
      assert generator.app
      path = generator.app_root

      %w|Gemfile Procfile Rakefile config.ru .gitignore app/api.rb config/application.rb config/db.yml db/.gitkeep lib/.gitkeep public/.gitkeep test/.gitkeep vendor/assets/javascripts/.gitkeep vendor/assets/stylesheets/.gitkeep vendor/assets/images/.gitkeep|.
      each do |file|
        assert exists?( path.join(file).to_s )
      end

    end

  end
end
