# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.2', '>= 7.0.2.4'

# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem 'propshaft', '~> 0.6'

# Use postgresql as the database for Active Record in dev
gem 'pg', '~> 1.3'

# Use cockroach as the database for Active Record in prod
gem 'activerecord-cockroachdb-adapter', github: 'keithdoggett/activerecord-cockroachdb-adapter', branch: 'ar-70'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.6'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails', '~> 1.0'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '~> 1.0'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '~> 1.0'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails', '~> 2.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder', '~> 2.11'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', '~> 1.2022', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '~> 1.11', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem 'image_processing', '~> 1.12'

# Use Pundit for authorization
gem 'pundit', '~> 2.2'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', '~> 1.5', platforms: %i[mri mingw x64_mingw]

  gem 'rubocop', '~> 1.28', require: false
  gem 'rubocop-rails', '~> 2.14', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console', '~> 4.2'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  gem 'rack-mini-profiler', '~> 3.0'

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  gem 'spring', '~> 4.0'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara', '~> 3.36'
  gem 'selenium-webdriver', '~> 4.1'
  gem 'webdrivers', '~> 5.0'
end

gem 'shopify_api', '~> 10.0'

gem 'jwt', '~> 2.3'

gem 'httparty', '~> 0.20.0'

gem 'sentry-rails', '~> 5.3'
gem 'sentry-ruby', '~> 5.3'

gem 'view_component', '~> 2.53'

gem 'view_component-form', '~> 0.2.4'

gem 'aws-sdk-s3', '~> 1.114', require: false

gem 'prometheus_exporter', '~> 2.0'

gem 'ruby-units', '~> 2.3'

gem 'iso_country_codes', '~> 0.7.8'

gem 'open-uri', '~> 0.2.0'

gem "actionpack-page_caching", "~> 1.2"
gem "actionpack-action_caching", "~> 1.2"

gem "foreman", "~> 0.87.2"

gem "rqrcode", "~> 2.1"
