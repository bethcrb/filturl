# == Schema Information
#
# Table name: webpage_redirects
#
#  id                  :integer          not null, primary key
#  url                 :string(2000)
#  webpage_response_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_webpage_redirects_on_webpage_response_id  (webpage_response_id)
#

require 'spec_helper'

describe WebpageRedirect do
  include_context 'skip screenshot callbacks'

  describe 'associations' do
    it { should belong_to(:webpage_response) }
  end

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should ensure_length_of(:url).is_at_most(2000) }

    it { should validate_presence_of(:webpage_response) }
  end
end
