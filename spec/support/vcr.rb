# VCR configuration options specific to RSpec
require_relative '../vcr_helper'

VCR.configure do |c|
  c.configure_rspec_metadata!
end
