set :default_stage, "staging"
set :stages, %w(production staging)
require 'capistrano/ext/multistage' # gem install capistrano-extensions

set :application, ""

set :scm, :git
set :scm_username, ""
set :scm_password, ""
set :repository,  ""
set :deploy_via, :remote_cache

# Only bother to keep the last five releases
set :keep_releases, 5

set :user, "user"
server "", :app, :web, :db, :primary => true

# Array of directories or fiels that should be preserved between
# deployments of the application.
# This assumes you store the shared files in the {deploy_to}/shared directory.
set :shared_assets, ['sites/default']

namespace :deploy do
  desc "Symlink shared folders on each release."
  task :symlink_shared do
    shared_assets.each do |shared_asset|
      run "ln -s #{deploy_to}/shared/#{shared_asset} #{release_path}/#{shared_asset}"
    end
  end
  before "deploy:symlink", "deploy:symlink_shared"
end

namespace :drush do
  desc "Clear the Drupal site cache"
  task :cc do
    run "cd #{current_path} && drush cc all"
  end
  after "deploy:symlink", "drush:cc"
end