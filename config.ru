ENV["RACK_ENV"] ||= "development"
require 'bundler'
Bundler.require(:default, ENV["RACK_ENV"])

require "./config/application"
require "./app/app"

get "/assets" do
  environemnt = ::Sprockets::Environment.new
  %w(javascripts stylesheets images templates).each do |path|
    environment.append_path "./app/assets/#{path}"
    environment.append_path "./vendor/assets/#{path}"
  end
  run environment
end

run Microsites::App.run!
