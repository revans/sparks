ENV["RACK_ENV"] ||= "development"
require 'pathname'
require 'logger'
require 'bundler'
Bundler.require(:default, ENV["RACK_ENV"])

module Microsites
  extend self
  def root
    ::Pathname.new(__FILE__).join("..").expand_path
  end

  def assets_path
    root.join("assets")
  end

  def vendor_assets_path
    root.join("vendor/assets")
  end
end

require "./config/application"
require "./app/app"

run Microsites::App.run!
