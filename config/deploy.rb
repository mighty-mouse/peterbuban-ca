set :application, 'portfolio'
set :repo_url, 'git@github.com:mighty-mouse/peterbuban-ca.git'
set :branch, 'master'


set :deploy_to, '/var/www/peterbuban-ca'
# set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true

# set :linked_files, %w{config/database.yml}
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

 desc 'Restart application'
 task :restart do
   on roles(:web), in: :sequence, wait: 5 do
     execute "cd #{current_path}; rm Vagrantfile Gemfile README.md .gitignore Capfile"
     execute "rm -r #{current_path}/config"
     #execute "rm -r #{current_path}/salt"
     #execute "rm -r #{current_path}/requirements"

     #execute "mkdir -pm 777 #{shared_path}/media"
     #execute "ln -s #{shared_path}/media #{current_path}/bensimonbyrne/media"
   end
 end

 after :restart, :clear_cache do
   on roles(:web), in: :groups, limit: 3, wait: 10 do
     # Here we can do anything such as:
     # within release_path do
     #   execute :rake, 'cache:clear'
     # end
   end
 end

 after :finishing, 'deploy:cleanup'

end