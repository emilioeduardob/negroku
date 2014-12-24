Negroku [![Stories in Ready](https://badge.waffle.io/platanus/negroku.svg)](http://waffle.io/platanus/negroku)
=======

Negroku is an opinionated collection of recipes for capistrano.

The goal is to be able to deploy **ruby applications** without the hassle of configure and define all the stuff involved in an application deployment.

## Installation

Install negroku as a global gem.

```shell
$ gem install negroku --pre
```

Add the negroku gem to your `Gemfile` development group to lock the version your are going to use.

```ruby
group :development do
    gem 'negroku', '~> 2.0.0.pre1'
end
```

Then run

```shell
$ bundle install
```

## Prepare your application

1. Create your app executing the following command, and just follow the on-screen questions.

    ```shell
    $ negroku app create
    ```

    1. **Give your application a name**

        This will be used to create the app folder structure in the server.

    1. **Please choose your repository url**

        You'll need to choose the git respository where your are going deploy your project from. Typically a GitHub repository.

        If you have already initializated your git repository for the project, you'll be offered to choose the remotes of the current repo.

    1. **Select the stages you are going to use**

        Negroku will create the stage configuration files for the stages you choose in this step


    The `app create` command will bootpstrap your app (behind the scenes it will run the `cap install` command and add some customizations)

        Some files and folders will be added to your project.

        ```
        project_root
         |--- Capfile                  # Capistrano load file
         +--- config
               |--- deploy.rb          # Global setting for all environments
        ```

1. Add a new stage for your deployment.

    ```shell
    $negroku stage add
    ```

    1. **Stage Name**

        This will be used to create de stage configuration files


    1. **Select the branch to use**

        Here you'll be presented with your remote branches (git branch -r) so you can choose which one you want to deploy the stage you are creating.

    1. **Type the domains to use**

        You can pass comma separated domains you want to use in the application

    1. **Type the server ur to deploy to**

        Set the server where you are going to deploy this stage

    1. **Do you want to add rbenv-vars to the server now?**

        If you choose 'y'es you wil able to create a `.rbenv-vars`  file in the server with the KEYS and VALUES you choose from your local `.rbenv-vars`

    The `stage add` command will create the stage configuration file and run the `rbenv:vars:add` capistrano task if you chosen to add environmental variables to the applicatin

    ```
    project_root
      +--- config
            +--- deploy
                +--- production.rb    # Specific settings for production server
    ```

1. In the `Capfile` you can enable and disabled the tasks you need in your application. You only have to comment out the stuff you don't need.

    ```ruby
    # Node
    require 'capistrano/nodenv'
    # require 'capistrano/bower'

    # App server
    require 'capistrano3/unicorn'

    # Static server
    require 'capistrano/nginx'
    ```

1. Configure your specific settings in the files created above

    1. Common settings for all stages `deploy.rb`

        Here you can add all the settings that are common to all the stage severs. For example: 

        ```ruby
        set :unicorn_workers, 1
        set :unicorn_workers_timeout, 30
        ```


    1. Per-stage settings `staging.rb` `production.rb`

        Here you can add all the settings that are specific to the stage. For example:

        ```ruby
        set :branch,        "production"        # Optional, defaults to master

        set :rails_env,        "production" 
        ```

1. Commit and push the changes to the repository

## Deploy you application

    To deploy your application you just need to run capistrano task to do so.

    ```shell
    $ cap staging deploy  # to deploy to the staging stage
    ```


