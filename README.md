# Recipes search by included ingredients App


## Table of Contents

* [Introduction](#introduction)
* [Install project](#install_project)
* [Prepopulate database](#fill_in_db)
* [Database diagram](#db_diagram)
* [Endpoints](#endpoints)
* [Server host](#server_host)
* [Improvements](#improvements)


<a name="introduction"></a>
## Introduction
App showing recipes including the chosen ingredients
- fill db with data from https://gist.github.com/quentindemetz/2096248a1e8d362e669350700e1e6add#data
- visit https://recipes-test123.herokuapp.com/recipes to be able to search for recipes

Used techs:
  - react to build the frontend (please do not take under account my frontend skills (learning phase) )
    - search field is using example from https://react-select.com/home
  - Ruby on Rails for backend

<a name="install_project"></a>
## Install project
* clone depository -> https://github.com/mlefterov86/recepti.git
* run -> `bundle exec install`
* create DB -> `bundle exec rake db:create` 
* run migrations -> `bundle exec rake db:migrate`
* [Prepopulate database](#fill_in_db)
* start rails server locally -> `bundle exec rails s`
* start webpacker locally -> `bin/webpack-dev-server`
* [Use endpoints](#endpoints)
* Run unit test locally `bundle exec rspec` (OPTIONAL)
  * Note: There might be more rspec to be added, examples of main one provided

<a name="fill_in_db"></a>
## Prepopulate database
There are two options to fill in DB
* Run a rake job (manually or via scheduler(CI integrated app or server cron)) - this job will prepopulate DB with data
  - `$ bundle exec rake fill_database_from_file`
* Visit the following endpoint - does the same as the rake job
  - `{server_host}/api/v1/fill_db`

  NOTE: I limit the DB entries to 1000 to speed up seeding DB

<a name="db_diagram"></a>
## Database diagram

You can find Database diagram in the repo `/app/assets/images/db_diagram.png`

<a name="endpoints"></a>
## Endpoints

There are two endpoints
* Servers to fetch data according to the passed params from the frontend
  - endpoint -> `{server_host}/api/v1/recipes`
* Will fill in DB
  - endpoint -> `{server_host}/api/v1/fill_db`


<a name="server_host"></a>
## Test App is deployed to Heroku 
Since app is deployed into a testing env on Heroku `{server_host} == 'https://recipes-test123.herokuapp.com/'` and you can use it in [Endpoints](#endpoints) and [Prepopulate database](#fill_in_db)

<a name="improvements"></a>
## Improvements
* to add paging to `recipes` endpoint
* js code is a bit outdated and not so consistent (even for a backend developer)
* DB tables might be constructed different ways for performance (I will need a bit more time to improve it)
* Respectivelly DB queries might be optimized
  * exclude n + 1 where possible (also there are gems like `bullet` helping reduce n+1)
  * reduce SQL queries for fetching data

