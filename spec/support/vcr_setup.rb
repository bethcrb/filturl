require "vcr"

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :typhoeus
  c.ignore_localhost = false
  c.default_cassette_options = { serialize_with: :json }
end
