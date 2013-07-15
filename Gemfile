source 'https://rubygems.org'

ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Use mysql as the database for Active Record
gem 'mysql2', '~> 0.3.11'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use Figaro for application configuration.
gem 'figaro', '~> 0.7.0'

# Gems for testing and debugging
group :development do
  # Better Errors replaces the standard Rails error page with a much better and more useful error page.
  gem 'better_errors', '~> 0.9.0'

  # binding_of_caller retrieves the binding of a method's caller. Used by Better Errors for advanced features.
  gem 'binding_of_caller', '~> 0.7.2'

  # Quiet Assets mutes assets pipeline log messages.
  gem 'quiet_assets', '~> 1.0.2'
end

group :test do
  # Use Capybara to simulate user interactions on the website.
  gem 'capybara', '~> 2.1.0'

  # Use Cucumber for behavior-driven development and integration testing.
  # NOTE: Temporarily using the master_rails4_test branch because the
  # stable release of 1.3.1 currently does not support Rails 4.
  gem 'cucumber-rails', :require => false, github: 'cucumber/cucumber-rails', :branch => 'master_rails4_test'

  # Use Database Cleaner to restore the database to a pristine state during testing.
  gem 'database_cleaner', '~> 1.0.1'

  # Use Email Spec for testing email with RSpec and Cucumber.
  gem 'email_spec', '~> 1.4.0'

  # Use Shoulda to write powerful tests with less code.
  gem 'shoulda', '~> 3.5.0'
end

group :development, :test do
  # Use Factory Girl for test objects.
  gem 'factory_girl_rails', '~> 4.2.1'

  # Use RSpec for unit testing.
  gem 'rspec-rails', '~> 2.14.0'
end

# Use Devise and Omniauth for authentication.
gem 'devise', '~> 3.0.0.rc'
gem 'omniauth-facebook', '~> 1.4.1'
gem 'omniauth-github', '~> 1.1.0'
gem 'omniauth-google-oauth2', '~> 0.2.0'
gem 'omniauth-twitter', '~> 1.0.0'

# Use CanCan to restrict access to pages that should only be viewed by an administrator.
gem 'cancan', '~> 1.6.10'

# Use Rolify to manage user roles.
gem 'rolify', '~> 3.3.0.rc4'

# Use Bootstrap for front-end framework.
gem 'bootstrap-sass', '~> 2.3.2.0'

# Use bootswatch-rails for SASS versions of Bootswatch themes.
gem 'bootswatch-rails', '~> 0.5.0'

# Use Simple Form to easily integrate Bootstrap styles in forms.
gem 'simple_form', '~> 3.0.0.rc'

# Rails 4 requires rails_12factor in order to configure application
# logs to be visible via heroku logs and to serve static assets. 
group :heroku do
  gem 'rails_12factor', '~> 0.0.2'
end

# Use Typhoeus to perform HTTP requests
gem 'typhoeus', '~> 0.6.3'

# Use Nokogiri for HTML parsing
gem 'nokogiri', '~> 1.6.0'

# Use Watir and Headless (Xvfb) for screenshots
gem 'headless', '~> 1.0.1'
gem 'watir', '~> 4.0.2'

# Use AWS SDK for S3
gem 'aws-sdk', '~> 1.0'
