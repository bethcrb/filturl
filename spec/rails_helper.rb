require 'rubygems'
require 'spork'

Spork.prefork do
  ENV['RAILS_ENV'] ||= 'test'
  require 'spec_helper'
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'email_spec'
  require 'shoulda/matchers/integrations/rspec'

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.maintain_test_schema!

  RSpec.configure do |config|
    AWS.stub!

    config.include FactoryGirl::Syntax::Methods

    # Include helpers and matchers for Email Spec
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)

    # Remove this line if you're not using ActiveRecord or ActiveRecord
    # fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
  end
end

Spork.each_run do
  require 'simplecov'
  SimpleCov.start 'rails'

  # Requires supporting ruby files with custom matchers and macros, etc, in
  # spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb`
  # are run as spec files by default. This means that files in spec/support
  # that end in _spec.rb will both be required and run as specs, causing the
  # specs to be run twice. It is recommended that you do not name files
  # matching this glob to end with _spec.rb. You can configure this pattern
  # with with the --pattern option on the command line or in ~/.rspec, .rspec
  # or `.rspec-local`.
  Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

  RSpec.configure do |config|
    # Configure Database Cleaner to reset database during testing
    config.before(:suite) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      Screenshot.all.find_each do |screenshot|
        screenshot_dir = Rails.root.join('tmp/screenshots').to_s
        unless screenshot.filename.blank?
          screenshot_file = "#{screenshot_dir}/#{screenshot.filename}"
          FileUtils.rm(screenshot_file) if File.exist?(screenshot_file)
        end
      end
      DatabaseCleaner.clean
    end
  end
end
