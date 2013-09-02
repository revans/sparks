require 'rubygems'
require 'bundler/setup'
Bundler.setup

require 'minitest/autorun'
require 'minitest/pride'

require './lib/sparks'

module TestHelper
  def silence_stdout(&block)
    $stdout = File.new( '/dev/null', 'w' )
    $stderr = File.new( '/dev/null', 'w' )
    yield if block_given?
  ensure
    $stdout = STDOUT
    $stderr = STDERR
  end
end
