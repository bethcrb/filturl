require "vcr"

VCR.configure do |c|
  c.hook_into :typhoeus
  c.cassette_library_dir = "features/cassettes"
end
