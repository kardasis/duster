# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

gem 'active_model_serializers'
gem 'aws-sdk-rails', '~> 3'
gem 'aws-sdk-s3', '~> 1'
gem 'bootsnap', require: false
gem 'chartkick', '~> 4.2'
gem 'groupdate'
gem 'jsbundling-rails', '~> 1.0'
gem 'jsonapi-serializer'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.3'
gem 'redis', '~> 4.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'tailwindcss-rails', '~> 2.0'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'view_component', '~> 2.61.0'

group :development, :test do
  gem 'dotenv-rails', '~> 2.7.6'
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'guard-rspec', require: false
  gem 'guard-rubocop', '~> 1.5.0'
  gem 'mock_redis', '~> 0.32.0'
  gem 'pry', '~> 0.13.1'
  gem 'rspec-rails', '~> 5.0.0'
  gem 'rubocop-rails', '~> 2.15.0', require: false
end

group :development do
  gem 'http'
  gem 'pry-rails', '~> 0.3.4'
  gem 'web-console'
end
