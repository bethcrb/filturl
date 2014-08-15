# VCR configuration options specific to Cucumber
require_relative '../../spec/vcr_helper'

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end
