# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.0.0'

gem 'rails', '~> 7.1.3'
gem 'sprockets-rails'

gem 'pg', '~> 1.1'

gem 'puma', '>= 5.0'

gem 'jsbundling-rails'

gem 'turbo-rails'

gem 'stimulus-rails'

gem 'jbuilder'

gem 'dotenv-rails'

gem 'vite_rails'

gem 'sassc-rails'

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

gem 'tzinfo-data', platforms: %i[windows jruby]

gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'pry', '~> 0.13'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'rubocop', '1.4.2', require: false
  gem 'rubocop-performance', '1.9.0', require: false
  gem 'web-console'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
end
