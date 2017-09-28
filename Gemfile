source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'

gem 'bcrypt', '~> 3.1.7'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'faker', :git => 'git://github.com/stympy/faker.git', :branch => 'master'
gem 'haml'
gem 'jbuilder', '~> 2.5'
gem 'mini_racer'
gem 'pg'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'rack-attack'
gem 'rails-controller-testing'
gem "react_on_rails", "9.0.0"
gem 'responders'
gem 'sidekiq'
gem "webpacker", "~> 3.0"


group :development, :test do
  gem 'pry-byebug'
  gem 'selenium-webdriver'
end

group :development do
  gem 'spring'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'guard'
  gem 'poltergeist' # headless javascript testing
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  gem 'shoulda'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'mini_racer', platforms: :ruby
