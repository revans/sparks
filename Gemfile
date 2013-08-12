source "https://rubygems.org"

gem 'sinatra'
gem "rack"
gem 'rake'

# gem "rack-contrib"
# gem "sinatra-contrib"

gem 'thin'
gem 'foreman'

group :production do
  # gem 'sequel_pg'
end

group :development, :test do
  # gem 'sequel'
  # gem 'pry'
  gem "sass"
  gem "coffee-script"
  gem "rack-livereload"

  # auto-compile
  gem "guard-sass",           require: false
  gem "guard-coffeescript",   require: false

  gem "bourbon"
  gem "neat"

  # compress js
  # gem "uglify"

  gem "rdoc"
end

group :test do
  # gem 'minitest'
  # gem 'rack-test'
end
