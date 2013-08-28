# Test Task
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files  = FileList['test/**/**/*_test.rb']
  t.verbose     = true
  Sparks.env    = 'test'
end

task :default => :test


namespace :test do
  desc "Sets the environment to 'test' for running tests"
  task :environment do
    Sparks.env  = 'test'
    DB          = Sparks::DB::Credentials.connect!(Sparks.load_database_config)
  end

  desc "Prepare the test database for running tests"
  task :prepare => :environment do
    Rake::Task['db:reset'].execute
  end
end
