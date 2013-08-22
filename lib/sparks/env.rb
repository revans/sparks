
module Sparks
  class Env
    class LineError < SyntaxError; end

    %w|development? test? staging? production?|.each do |environment|
      define_method(environment) do
        environment.sub('?', '').to_s == Sparks.env
      end
    end

    %w|development? test? staging? production?|.each do |environment|
      self.class.send(:define_method, environment) do
        environment.sub('?', '').to_s == Sparks.env
      end
    end

    def self.load(filename = ".env")
      Reader.new(filename).apply
    end

    # attr_reader :rack_env, :port
    def initialize(options)
      options.each do |key,value|
        instance_variable_set("@#{key.downcase}", value)
        self.class.attr_reader key.downcase.to_sym
      end
    end

    class Reader < Hash
      LINE = /
        \A
        (?:export\s+)?    # optional export
        ([\w\.]+)         # key
        (?:\s*=\s*|:\s+?) # separator
        (                 # value begin
          '(?:\'|[^'])*'  #   single quoted value
          |               #   or
          "(?:\"|[^"])*"  #   double quoted value
          |               #   or
          [^#\n]+         #   unquoted value
        )                 # value end
        (?:\s*\#.*)?      # optional comment
        \z
      /x

      def initialize(filename)
        @filename = filename
        load
      end

      def load
        read.each do |line|
          if match = line.match(LINE)
            key, value = match.captures
            value = value.strip.sub(/\A(['"])(.*)\1\z/, '\2')
            value = value.gsub('\n', "\n").gsub(/\\(.)/, '\1') if $1 == '"'
            self[key] = value
          # not comment or blank line
          elsif line !~ /\A\s*(?:#.*)?\z/
            raise LineError, "Line #{line.inspect} doesn't match desired format."
          end
        end
      end

      def apply
        each { |key, value| ENV[key] = value }
      end

      private

      def read
        ::File.read(@filename).split("\n")
      end
    end

  end
end
