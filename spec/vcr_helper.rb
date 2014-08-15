# Shared VCR configuration
# See spec/support/vcr.rb for configuration options specific to RSpec
# See features/support/vcr.rb for configuration options specific to Cucumber
VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = false
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.ignore_hosts '127.0.0.1', 'localhost'
end
