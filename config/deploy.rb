before 'deploy:setup', 'rvm:install_rvm'
before 'deploy:setup', 'rvm:install_ruby'

require "rvm/capistrano"                               # Load RVM's capistrano plugin.
require "bundler/capistrano"
# bundler bootstrap
# set :bundle_roles, [:app]

set :rvm_path, "$HOME/.rvm"
# set :rvm_ruby_string, 'ruby-1.9.3-p392@mccustom'
set :rvm_ruby_string, ENV['GEM_HOME'].gsub(/.*\//,"") # Read from local system
set :rvm_type, :user
set :normalize_asset_timestamps, false

set :application, "mccustom"
role :web, "50.116.52.170:22"                          # Your HTTP server, Apache/etc
role :app, "50.116.52.170:22"                          # This may be the same as your `Web` server
role :db,  "50.116.52.170:22", :primary => true
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
#
# # Deploy from your local Git repo by cloning and uploading a tarball
set :scm, :git
set :repository,  "git@github.com:zigloo99/mccustom.git"
set :deploy_via, :remote_cache
set :branch, "master"
set :ssh_options,     { :forward_agent => true }
set :git_enable_submodules, 1
set :scm_verbose, true

set :user, :deploy
set :deploy_to, "/var/www/#{application}"
set :use_sudo, false

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

set :keep_releases, 10
after "deploy:restart", "deploy:cleanup"

