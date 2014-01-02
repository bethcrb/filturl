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

require 'spec_helper'

describe Webpage do
  include_context 'skip screenshot callbacks'

  describe 'associations' do
    it { should have_one(:screenshot).dependent(:destroy) }

    it { should have_many(:webpage_responses).dependent(:destroy) }
    it { should have_many(:webpage_requests).through(:webpage_responses) }
    it { should have_many(:url_histories).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
    it { should ensure_length_of(:url).is_at_most(2000) }
    it { should_not allow_value('www.example.com').for(:url) }
    it { should allow_value('http://www.example.com/').for(:url) }
  end

  describe ':after_create' do
    it 'should create a screenshot object' do
      webpage = create(:webpage)
      webpage.screenshot.should_not be_nil
    end
  end

  describe 'encoding' do
    it 'should be utf-8 for french' do
      webpage = create(:french_webpage)
      webpage.body.is_utf8?.should be_true
    end

    it 'should be utf-8 for hebrew' do
      webpage = create(:hebrew_webpage)
      webpage.body.is_utf8?.should be_true
    end

    it 'should be utf-8 for japanese' do
      webpage = create(:japanese_webpage)
      webpage.body.is_utf8?.should be_true
    end

    it 'should be utf-8 for russian' do
      webpage = create(:russian_webpage)
      webpage.body.is_utf8?.should be_true
    end
  end
end
