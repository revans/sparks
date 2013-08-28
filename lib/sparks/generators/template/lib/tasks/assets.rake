
namespace :assets do
  desc "Install Bourbon, Neat, and generate the Grid Settings Stylesheet"
  task :install do
    Rake::Task["assets:install:bourbon"].invoke
    Rake::Task["assets:install:grid_settings"].invoke
    Rake::Task["assets:install:neat"].invoke
  end

  namespace :install do
    desc "Install bourbon"
    task :bourbon do
      `bourbon install --path assets/stylesheets`
    end

    desc "Install bouron neat"
    task :neat do
      `neat install`
      `mv neat assets/stylesheets`
    end

    desc "Generate Grid Settings Stylesheet"
    task :grid_settings do
      `touch assets/stylesheets/grid-settings.scss`
    end
  end
end
