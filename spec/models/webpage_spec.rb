# == Schema Information
#
# Table name: webpages
#
#  id            :integer          not null, primary key
#  url           :string(2000)     default(""), not null
#  slug          :string(255)
#  primary_ip    :string(255)
#  body          :text(2147483647)
#  content_type  :string(255)
#  meta_encoding :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_webpages_on_slug  (slug) UNIQUE
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

  describe 'respond_to' do
    it { should respond_to(:screenshot_url) }
  end

  describe '#location' do
    subject(:webpage) { build_stubbed(:webpage) }
    it { expect(webpage).to respond_to(:location) }
    it { expect(webpage.location).to be_a(WebpageLocation) }
  end

  describe '#normalize_friendly_id' do
    context 'when the url is longer than 255 characters' do
      subject(:webpage) { create(:webpage, :lengthy_url) }
      it 'shortens the slug to 255 characters' do
        expect(webpage.slug.length).to eq(255)
      end

      it 'uses the first 228 and the last 25 characters of the URL' do
        url = webpage.url.parameterize
        expect(webpage.slug).to eq("#{url[0..227]}--#{url[-25..-1]}")
      end
    end

    context 'when the url is less than 255 characters' do
      subject(:webpage) { create(:webpage) }
      it 'uses the parameterized url as the slug' do
        expect(webpage.slug).to eq(webpage.url.parameterize)
      end
    end
  end
end
