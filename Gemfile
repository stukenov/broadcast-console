source "https://rubygems.org"

ruby "3.2.3"

gem "rails", "~> 8.1.3"

gem "sprockets-rails"

gem "sidekiq"
gem "sidekiq-scheduler"

gem "pg", ">= 1.2", "< 2.0"
gem "rack-cors"

gem "puma", ">= 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "jbuilder"

gem "redis", "5.4.1"

gem "bcrypt", "~> 3.1.22"

gem "tzinfo-data", platforms: %i[windows jruby]

gem "bootsnap", require: false

gem "image_processing", "~> 2.0"

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
