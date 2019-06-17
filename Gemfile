# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.0'
gem 'active_link_to'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'bootstrap', '>= 4.3.1'
gem 'breadcrumbs_on_rails'
gem 'carrierwave', '~> 1.0'
gem 'carrierwave-i18n'
gem 'coffee-rails', '~> 4.2'
gem 'devise', '>= 4.6.0'
gem 'font-awesome-rails'
gem 'font-ionicons-rails'
gem 'i18n_rails_helpers'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails', '~> 4.3', '>= 4.3.1'
gem 'jquery-turbolinks'
gem 'lte-rails'
gem 'kaminari'
gem 'mini_magick', '~> 4.3'
gem 'pg', '0.18.4'
gem 'puma', '~> 3.11'
gem 'rails', '~> 5.2.1'
gem 'rails-i18n', '~> 5.1', '>= 5.1.1'
gem 'rubocop-performance'
gem 'sass-rails', '~> 5.0'
gem 'simple_form'
#gem 'turbolinks', '~> 5.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate-bootstrap4'

# relatorios pdf
gem 'prawn'
gem 'prawn-table'
gem 'responders'

# relatorios pdf
gem 'prawn-rails'

# breadcrumbs
gem 'gretel', '~> 3.0', '>= 3.0.9'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  gem 'factory_bot_rails'
  gem 'faker'
  gem 'fuubar'
  gem 'rspec-rails', '~> 3.7'
  gem 'brakeman', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec', require: false
  gem 'bullet'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'

  gem 'capistrano',         require: false
  gem 'sshkit-sudo',        require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
  gem 'capistrano-rails-db', require: false

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman'
  gem 'guard-rspec', require: false
  gem 'rubocop', require: false
  gem 'rubocop-rspec'
  gem 'rubycritic', require: false
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'

  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'simplecov', require: false
  gem 'simplecov-console', require: false
  gem 'guard-rspec', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
