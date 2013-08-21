namespace :db do
  # def connect
  #   ::Database::Connection
  # end

  desc "Create database"
  task :create => :environment do
  end

  desc "Drop the stores table"
  task :drop => :environment do
    DB.tables.each do |table|
      DB.drop_table(table)
    end unless DB.tables.empty?
  end

  desc "Migrate database"
  task :migrate => :environment do
    Sequel::Migrator.run(DB, "db/migrate")
  end

  desc "create superuser"
  task :user do
    `createuser #{connect.user} -d -s`
  end

  desc "Drop the database and recreate it"
  task :reset => :environment do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:migrate'].execute
  end

  desc "Dump the database's schema"
  task :schema => :environment do
    File.open(Sparks.root.join("db/schema.rb").to_s, "w") do |file|
      file.puts DB.dump_schema_migration(same_db: true)
    end
  end

  desc "Print the current schema version to STDOUT"
  task :version => :environment do
    puts "Schema Version: #{schema_version}"
  end


  def schema_version
    return DB[:schema_info].first[:version].to_i if DB.tables.include?(:schema_info)
    return 0
  end
end
