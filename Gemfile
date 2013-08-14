source "https://rubygems.org"

gem 'sinatra'
gem "rack"
gem 'rake'

gem 'thin'
gem 'foreman'

# gem "rack-contrib"
# gem "sinatra-contrib"


group :production do
  gem 'sequel_pg'
end

group :development do
  # styling
  gem "bourbon"
  gem "neat"

  # development tools
  gem "sass"
  gem "coffee-script"
  gem "rack-livereload"

  # auto-compile
  gem "guard-sass"
  gem "guard-coffeescript"
  gem "guard-livereload"

  # compress js
  # gem "uglify"

  gem "rdoc"
end

group :development, :test do
  gem 'sequel'
  gem 'pry'
end

group :test do
  gem 'minitest'
  gem 'rack-test'
end
