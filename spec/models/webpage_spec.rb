# == Schema Information
#
# Table name: webpages
#
#  id            :integer          not null, primary key
#  url           :string(2000)     default(""), not null
#  primary_ip    :string(255)
#  body          :text(2147483647)
#  content_type  :string(255)
#  meta_encoding :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'rails_helper'

RSpec.describe Webpage, type: :model do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe 'associations' do
    it { is_expected.to have_one(:screenshot).dependent(:destroy) }

    it { is_expected.to have_many(:webpage_responses).dependent(:destroy) }
    it { is_expected.to have_many(:webpage_requests).through(:webpage_responses) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }
    it { is_expected.to ensure_length_of(:url).is_at_most(2000) }
    it { is_expected.not_to allow_value('www.example.com').for(:url) }
    it { is_expected.to allow_value('http://www.example.com/').for(:url) }
  end

  describe ':after_create' do
    it 'creates a screenshot object' do
      webpage = create(:webpage)
      expect(webpage.screenshot).not_to be_nil
    end
  end

  describe '#location' do
    subject(:webpage) { build_stubbed(:webpage) }
    it { expect(webpage).to respond_to(:location) }
    it { expect(webpage.location).to be_a(WebpageLocation) }
  end
end
