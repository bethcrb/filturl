# == Schema Information
#
# Table name: webpage_redirects
#
#  id                  :integer          not null, primary key
#  url                 :string(255)
#  webpage_response_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe WebpageRedirect do
  include_context 'skip screenshot callbacks'

  describe 'associations' do
    it { should belong_to(:webpage_response) }
  end

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should_not allow_value('www.example.com').for(:url) }
    it { should allow_value('http://www.example.com/').for(:url) }

    it { should validate_presence_of(:webpage_response) }
  end
end
