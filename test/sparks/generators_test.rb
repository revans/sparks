require "test_helper"
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

  def test_app_generation_with_path_given
    gen = Sparks::Generators.new("./test/maven")

    assert_equal File.join(Dir.pwd, "test/maven"), gen.app_root.to_s
    assert_equal "maven", gen.appname
  end

  def test_app_generation_without_path_given
    gen = Sparks::Generators.new("breathe")

    assert_equal File.join(Dir.pwd, "breathe"), gen.app_root.to_s
    assert_equal "breathe", gen.appname
  end

  def test_app_generation
    expected_app_path       = File.join(Dir.pwd, 'test/zues')
    expected_template_path  = File.join(Dir.pwd, "lib/sparks/generators/template")

    temp do |generator|

      assert_equal expected_app_path,       generator.app_root.to_s
      assert_equal expected_template_path,  generator.template_root.to_s

      # assert gen.build
      assert generator.app
      path = generator.app_root

      # goes through the array checking to make sure each file
      # has been generated
      %w|Gemfile Procfile Rakefile config.ru .env .gitignore apps/api.rb config/application.rb config/db.yml db/.gitkeep test/.gitkeep vendor/assets/javascripts/.gitkeep vendor/assets/stylesheets/.gitkeep vendor/assets/images/.gitkeep lib/tasks/assets.rake lib/tasks/db.rake lib/tasks/test.rake Guardfile|.
      each do |file|
        assert exists?( path.join(file).to_s ), "#{file} does not exists."
      end

      # TODO: make sure the empty folders with gitkeep exist

    end

  end
end
