require 'pathname'
require 'fileutils'
require 'erb'

module Sparks
  class Generators
    def self.generate(name)
      new(name).app
    end

    attr_reader :appname, :appath
    def initialize(name)
      @appath   = ::Pathname.new(Dir.pwd).join(name).expand_path.dirname
      @appname  = ::Pathname.new(name).basename.to_s.downcase
    end

    def app
      appath.mkpath
      build_app
    end

    def module_classname
      appname.capitalize
    end

    def template_root
      ::Pathname.new(__dir__).join('generators/template')
    end

    def app_root
      ::Pathname.new(appath).join(appname).expand_path
    end

    def get_binding
      binding
    end

    def build_app
      create_directories
      gitkeep_empty_dirs
      write_files
      copy_files
    end

    def create_directories
      %w|app/views
         app/helpers
         app/assets/javascripts
         app/assets/stylesheets
         app/assets/images
         app/assets/fonts
         app/assets/templates
         config
         db
         doc
         lib/tasks
         public
         test
         vendor/assets/stylesheets
         vendor/assets/javascripts
         vendor/assets/images
         vendor/assets/fonts|.
      each { |dir| create_directory(dir) }
    end

    def gitkeep_empty_dirs
      %w|app/views
         app/helpers
         db
         test
         vendor/assets/javascripts
         vendor/assets/stylesheets
         vendor/assets/images|.
      each { |dir| add_gitkeep(dir) }
    end

    def write_files
      %w|Gemfile
         Guardfile
         Procfile
         Rakefile
         config.ru.erb
         .env
         .gitignore
         app/api.rb.erb
         config/application.rb.erb
         config/db.yml.erb
         app/assets/javascripts/application.coffee
         app/assets/stylesheets/application.scss
         public/humans.txt
         public/robots.txt
         lib/tasks/assets.rake
         lib/tasks/db.rake
         lib/tasks/test.rake
        |.
      each { |file| write_file(file) }
    end

    def copy_files
      ['app/views/layout.erb'].each do |file|
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
      ::ERB.new(content).result(get_binding)
    end

    def format_erb_filename(file)
      file.to_s.split('.erb').first
    end

    def add_gitkeep(path)
      ::FileUtils.touch( app_root.join(path).join('.gitkeep').to_s )
    end

  end
end
