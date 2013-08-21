require 'pathname'
require 'fileutils'
require 'erb'

module Sparks
  module Generators
    extend self

    def generate_app(name)
      @appname = name
      self
    end

    def build
      build_app
      self
    end

    def appname
      @appname.downcase
    end

    def module_classname
      @appname.capitalize
    end

    def template_root
      ::Pathname.new(__dir__).join('generators/template')
    end

    def app_root
      ::Pathname.new(Dir.pwd).join(appname)
    end

    private

    def build_app
      create_directories
      create_app_assets
      create_assets
      create_views
      create_helpers
      create_files
      copy_files
    end

    def create_directories
      %w|app config db doc lib public test|.each { |dir| create_directory(dir) }
    end

    def create_app_assets
      %w|javascripts stylesheets images fonts templates|.each do |dir|
        assert = "app/assets/#{dir}"
        create_directory(asset)
        add_gitkeep(asset)
      end
    end

    def create_assets
      %w|javascripts stylesheets images fonts|.each do |dir|
        asset = "vendor/assets/#{dir}"
        create_directory(asset)
        add_gitkeep(asset)
      end
    end

    def create_views
      create_directory("app/views")
      add_gitkeep("app/views")
    end

    def create_helpers
      create_directory("app/helpers")
      add_gitkeep("app/helpers")
    end

    def create_files
      ['Gemfile', 'Procfile', 'Rakefile', 'config.ru.erb', '.gitignore', 'app/api.rb.erb', 'config/application.rb.erb', 'config/db.yml.erb', 'app/assets/javascripts/application.coffee', 'app/assets/stylesheets/application.scss'].
      each do |file|
        write_file(file)
      end
    end

    def copy_files
      ['app/views/layout.html.erb'].each do |file|
        copy_file(file)
      end
    end

    def copy_file(file)
      contents = template_root.join(file).read
      ::File.open( app_root.join(file).to_s, 'w+') do |f|
        f.puts contents
      end
    end

    ###################################################
    def create_directory(dir)
      ::FileUtils.mkdir_p( app_root.join(dir).to_s )
    end

    def write_file(file)
      filename = format_erb_filename(file)
      content  = read_erb( template_root.join(file).read )

      ::File.open(app_root.join(filename).to_s, 'w+') do |f|
        f.puts content
      end
    end

    def read_erb(content)
      ::ERB.new(content).result(binding)
    end

    def format_erb_filename(file)
      file.to_s.split('.erb').first
    end

    def add_gitkeep(path)
      ::FileUtils.touch( app_root.join(path).join('.gitkeep').to_s )
    end

  end
end
