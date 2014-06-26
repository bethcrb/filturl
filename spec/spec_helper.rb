require 'rubygems'
require 'spork'

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV['RAILS_ENV'] ||= 'test'
  require File.expand_path('../../config/environment', __FILE__)
  require 'rspec/rails'
  require 'email_spec'
  require 'rspec/autorun'
  require 'shoulda/matchers/integrations/rspec'

  # Checks for pending migrations before tests are run.
  # If you are not using ActiveRecord, you can remove this line.
  ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

  RSpec.configure do |config|
    AWS.stub!

    config.include FactoryGirl::Syntax::Methods

    # Include helpers and matchers for Email Spec
    config.include(EmailSpec::Helpers)
    config.include(EmailSpec::Matchers)

    # So that VCR RSpec metadata can be used with :vcr instead of :vcr => true
    config.treat_symbols_as_metadata_keys_with_true_values = true

    # ## Mock Framework
    config.mock_with :rspec

    # Remove this line if you're not using ActiveRecord or ActiveRecord
    # fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"

    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true

    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false

    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = 'random'

    # Only accept the new expect syntax for RSpec
    config.expect_with :rspec do |c|
      c.syntax = :expect
    end
  end
end

Spork.each_run do
  require 'simplecov'
  SimpleCov.start 'rails'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
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
      screenshot_dir = Rails.root.join('tmp/screenshots').to_s
      Screenshot.all.find_each do |screenshot|
        next if screenshot.filename.blank?
        screenshot_file = "#{screenshot_dir}/#{screenshot.filename}"
        File.exist?(screenshot_file) && File.delete(screenshot_file)
      end
      DatabaseCleaner.clean
    end
  end
end
