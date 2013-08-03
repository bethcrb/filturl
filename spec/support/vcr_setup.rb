require 'vcr'

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.ignore_hosts '127.0.0.1', 'localhost', 'not.a.valid.url'
  c.default_cassette_options = { serialize_with: :json }
end
