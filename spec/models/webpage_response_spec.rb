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

require 'spec_helper'

describe WebpageResponse do
  include_context 'skip screenshot callbacks'

  describe 'associations' do
    it { should belong_to(:webpage_request) }
    it { should belong_to(:webpage) }

    it { should have_one(:screenshot).through(:webpage) }

  end

  describe 'validations' do
    it { should validate_presence_of(:webpage_request) }
  end

  describe 'respond_to' do
    it { should respond_to(:get_url) }
  end

  describe 'get_url' do
    let (:original_response) { build_stubbed(:webpage_response, code: -999) }
    it 'should update the response data', :vcr do
      original_response.get_url
      original_response.code.should_not == -999
    end
  end
end
