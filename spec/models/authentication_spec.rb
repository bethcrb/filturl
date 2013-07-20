require 'spec_helper'

describe Authentication do
  it { should belong_to(:user) }
end
