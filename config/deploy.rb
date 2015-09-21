# config valid only for Capistrano 3.1
 lock '3.4.0'

set :application, 'demo'
set :repo_url, 'https://github.com/kewaunited/demo.git'
set :deploy_user, 'deploy'

# rbenv
set :rbenv_type, :user
set :rbenv_ruby, '2.2.3'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'
set :deploy_to, '/home/deploy/demo'

# Default value for :scm is :git
set :scm, :git

# set :tmp_dir, "/tmp"
# set :tmp_dir, "/var/www/tmp"
# Default value for :format is :pretty
# set :format, :pretty

set :local_repository, "file://."
set :branch, 'master'
set :deploy_via, :remote_cache

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  # desc 'Restart application'
  # task :restart do
  #  on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
  #    execute :touch, release_path.join('tmp/restart.txt')
  #  end
  # end

 # after :publishing, :restart
 # after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'

#  after :restart, :clear_cache do
#    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
#    end
#  end

end
