guard 'sass',         input: 'app/assets/stylesheets',    output: 'public/stylesheets'
guard 'coffeescript', input: 'app/assets/coffeescripts',  output: 'public/javascripts'

guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  # watch(%r{config/locales/.+\.yml})
end
