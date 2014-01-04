# VCR configuration for RSpec
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.configure_rspec_metadata!
  c.hook_into :webmock
  c.ignore_hosts '127.0.0.1', 'localhost'
end
