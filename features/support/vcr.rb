require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "features/cassettes"
  c.hook_into :typhoeus
  c.ignore_hosts "not.a.valid.url"
end
