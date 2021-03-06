require 'negroku/helpers'

# Base configuration
namespace :load do
  task :defaults do

    set :scm, :git

    set :format, :pretty
    set :log_level, :debug
    set :pty, true

    set :keep_releases, 5

    set :linked_dirs, fetch(:linked_dirs, []) + %w{log tmp/pids tmp/cache tmp/sockets public/system}

    set :linked_files, fetch(:linked_files, []) + %w{}
  end

  after "deploy", "deploy:cleanup"
end

# Load Negroku tasks
load_task "env"
load_task "rbenv"             if required? 'capistrano/rbenv'
load_task "nodenv"            if required? 'capistrano/nodenv'
load_task "bower"             if required? 'capistrano/bower'
load_task "bundler"           if required? 'capistrano/bundler'
load_task "rails"             if required? 'capistrano/rails'
load_task "nginx"             if required? 'capistrano/nginx'
load_task "unicorn"           if required? 'capistrano3/unicorn'
load_task "puma"              if required? 'capistrano/puma'
load_task "delayed_job"       if required? 'capistrano/delayed-job'
load_task "github"            if required? 'capistrano/github'
load_task "whenever"          if required? 'whenever/capistrano'
load_task "thinking_sphinx"   if required? 'thinking_sphinx/capistrano'
load_task "log"
