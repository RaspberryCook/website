# config valid only for current version of Capistrano
lock '3.4.0'

set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :application, 'raspberry_cook'
set :repo_url, 'https://github.com/madeindjs/raspberry_cook.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :updated, :bundle_install do
  	# invoke "ruby_on_rails:copy_database_configuration"
  	# invoke "ruby_on_rails:bundle_install"
  	# invoke "ruby_on_rails:db_migrate"
  	# invoke "ruby_on_rails:assets_precompile"
  end

end
