# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(255)      not null
#  slug       :string(255)
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe WebpageRequest, :vcr do
  describe 'associations' do
    it { should belong_to(:user) }

    it { should have_one(:webpage_response).dependent(:destroy) }
    it { should have_one(:webpage).through(:webpage_response) }
    it { should have_one(:webpage_screenshot).through(:webpage) }
  end

  describe 'before validation' do
    let(:new_webpage_request) { build(:webpage_request, url: 'example.com') }

    it 'should clean the url' do
      new_webpage_request.valid?
      new_webpage_request.url.should == 'http://example.com/'
    end
  end

  describe 'validations' do
    let!(:webpage_request) {
      VCR.use_cassette('http_google_com') { create(:webpage_request) }
    }

    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url).scoped_to(:user_id) }

    invalid_urls = %w(
      file://example.doc
      ftp://ftp.test.com
      gopher://domain.com
      htt://www.$example.com
      httptest
    )
    invalid_urls.each do |url|
      cassette = url.gsub(/\W+/, '_')
      it {
        VCR.use_cassette(cassette) { should_not allow_value(url).for(:url) }
      }
    end

    valid_urls = %w(
      http://www.example.com
      http://www.microsoft.com/page.html#anchor
      https://www.domain.com/?query=value
    )
    valid_urls.each do |url|
      cassette = url.gsub(/\W+/, '_')
      it {
        VCR.use_cassette(cassette) { should allow_value(url).for(:url) }
      }
    end
  end
end
