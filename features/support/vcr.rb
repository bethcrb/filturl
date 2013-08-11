# VCR configuration for Cucumber
require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.hook_into :webmock
  c.ignore_hosts '127.0.0.1', 'localhost', 'not.a.valid.url'
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end
