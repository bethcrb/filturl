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

require 'rails_helper'

RSpec.describe WebpageRedirect, type: :model do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe 'associations' do
    it { is_expected.to belong_to(:webpage_response) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to ensure_length_of(:url).is_at_most(2000) }

    it { is_expected.to validate_presence_of(:webpage_response) }
  end
end
