# README

This repository shall provide some boilerplate code for Rails 5.1 applications. You'll find several base setups mainly following the react on rails path.

Currently implemented

- [Basic React on Rails setup](https://github.com/andneuma/rails_base_project)
- [User authentication](https://github.com/andneuma/rails_base_project/tree/user_authentication)

# PREREQUISITS

* Ruby version: 2.3.1

* Database: PostgreSQL

* Yarn, please visit https://yarnpkg.com/lang/en/docs/install/ for further information on how to install on your system

* Foreman: Install via `gem install foreman`

# FEATURES

* React

* ES6 / Babel

# BASIC SETUP

* Clone repo: `git clone https://github.com/andneuma/rails_base_project/tree/<branch_name>`

* Setup DB: `rake db:create db:migrate`

* Fetch gems and JS dependencies: `bundle && yarn`

* _Optionally: Checkout wheteher test-suite passes locally `rspec`_

* Launch development server: `foreman start -f Procfile.dev`

_Note: **Foreman** is a tool to manage background processes in a development setup like sidekiq, etc. Define the processes within Procfile.dev. Checkout this RailsCast episode to get further information on how foreman https://www.youtube.com/watch?v=zpEcox47ZV0

* Visit http://localhost:3000/hello_world to check out whether sample react component is working properly
