# == Schema Information
#
# Table name: webpage_responses
#
#  id                 :integer          not null, primary key
#  redirect_count     :integer
#  code               :integer
#  headers            :text
#  webpage_request_id :integer
#  webpage_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_webpage_responses_on_webpage_id          (webpage_id)
#  index_webpage_responses_on_webpage_request_id  (webpage_request_id)
#

require 'rails_helper'

RSpec.describe WebpageResponse, type: :model do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe 'associations' do
    it { is_expected.to belong_to(:webpage_request) }
    it { is_expected.to belong_to(:webpage) }

    it { is_expected.to have_one(:screenshot).through(:webpage) }

  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:webpage_request) }
  end
end
