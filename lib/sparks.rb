require 'pathname'
require 'erb'
require 'fileutils'

module Sparks
  class Generate

    def self.app(name, path)
      generator = Generator.new(name, path)
      generator.generate_app
      generator.copy_app
      # TODO: iterate over the files necessary
    end

  end

  class Generator
    attr_reader :name, :path, :template_path

    def initialize(name, path)
      @name, @path    = name, ::Pathname.new(path).expand_path.join(name)
      @template_path  = ::Pathname.new(__dir__).expand_path.join("template")
    end

    def generate_app
      path.mkpath
    end

    def copy_app
      ::FileUtils.cp_r(template_path.join("/"), path, noop: true, verbose: true)
    end

    # TODO: path...
    def copy_file(filename)
      ::FileUtils.cp_r(template_path.join(filename), path.join(filename), noop: true, verbose: true)
    end

    # TODO: path...
    def generate_file(filename)
      content = erb_render( read_file(filename) )
      ::File.open(filename, "w+") { |file| file.puts content }
    end

    def render_erb(content)
      ::ERB.new(content).result
    end

    def read_file(filename)
      template_path.join(filename).read
    end

    def report(msg)
      $stderr.puts "--> #{msg}"
    end

  end
end
