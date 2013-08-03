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

describe WebpageRequest do
  describe 'associations' do
    it { should belong_to(:user) }

    it { should have_one(:webpage_response).dependent(:destroy) }
    it { should have_one(:webpage).through(:webpage_response) }
    it { should have_one(:webpage_screenshot).through(:webpage) }
  end

  describe 'before validation' do
    subject { build_stubbed(:webpage_request, url: 'www.example.com') }

    it 'should clean the url' do
      subject.valid?
      subject.url.should == 'http://www.example.com/'
    end
  end

  describe 'validations' do
    subject { VCR.use_cassette('http_www_google_com') { create(:webpage_request) } }

    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url).scoped_to(:user_id) }

    invalid_urls = %w(
      file://example.doc
      ftp://ftp.test.com
      gopher://domain.com
      htt://www.$example.com
      httptest
      http://not.a.valid.url/
      http://www.unknown_response.com/
    )
    invalid_urls.each do |url|
      cassette = url.parameterize('_')
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
      cassette = url.parameterize('_')
      it {
        VCR.use_cassette(cassette) { should allow_value(url).for(:url) }
      }
    end
  end

  describe 'normalize_friendly_id' do
    subject { build_stubbed(:webpage_request) }

    it "should return a parameterized version of the url with the user id" do
      friendly_id_slug = "#{subject.url.parameterize}-#{subject.user_id}"
      subject.normalize_friendly_id(subject.url).should == "#{friendly_id_slug}"
    end
  end
end
