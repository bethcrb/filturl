require "vcr"

VCR.configure do |c|
  c.configure_rspec_metadata!
  c.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  c.hook_into :typhoeus
end
