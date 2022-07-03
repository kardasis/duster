# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.3'

gem 'active_model_serializers'
gem 'bootsnap', require: false
gem 'importmap-rails'
gem 'jbuilder'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'sqlite3', '~> 1.4'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'guard-rspec', require: false
  gem 'pry', '~> 0.13.1'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop-rails', '~>2.15.0', require: false
end

group :development do
  gem 'web-console'
end
