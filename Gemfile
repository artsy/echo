source 'https://rubygems.org'
ruby '2.2.2'

gem 'rack-cors'
gem 'pg'
gem 'activerecord', require: 'active_record'
gem 'json'

gem 'gris'
gem 'gris_paginator'
gem 'gris-toko_ohno'

gem 'roar'
gem 'grape-roar'
gem 'grape-swagger'
gem 'kaminari', require: 'kaminari/grape'
gem 'puma'

group :development, :test do
  gem 'pry'
  gem 'hyperclient'
end

group :development do
  gem 'rubocop', require: false
  gem 'shotgun', require: false
end

group :test do
  gem 'fabrication'
  gem 'rspec'
  gem 'shoulda-matchers'
  gem 'rack-test'
  gem 'simplecov'
  gem 'webmock'
  gem 'database_cleaner'
end
