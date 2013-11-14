# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(2000)     not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe WebpageRequest do
  include_context 'skip screenshot callbacks'

  describe 'associations' do
    it { should belong_to(:user) }

    it { should have_one(:webpage_response).dependent(:destroy) }
    it { should have_one(:webpage).through(:webpage_response) }
    it { should have_one(:screenshot).through(:webpage) }
  end

  describe 'before validation' do
    subject { build_stubbed(:webpage_request, url: 'www.example.com') }

    it 'should clean the url' do
      subject.valid?
      subject.url.should == 'http://www.example.com/'
    end
  end

  describe 'validations' do
    subject { build(:webpage_request) }

    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:url) }
    it { should ensure_length_of(:url).is_at_most(2000) }

    it 'should require unique value for url scoped to user_id', :vcr do
      subject.save!
      should validate_uniqueness_of(:url).scoped_to(:user_id)
    end

    invalid_urls = %w(
      file://example.doc
      ftp://ftp.test.com
      gopher://domain.com
      htt://www.$example.com
      httptest
      http://not.a.valid.url/
      http://www.unknown_response.com/
      http://localhost:3000/logo.png
    )
    invalid_urls.each do |url|
      it "should not allow url to be set to \"#{url}\"", :vcr do
        should_not allow_value(url).for(:url)
      end
    end

    valid_urls = %w(
      http://www.example.com
      http://www.microsoft.com/page.html#anchor
      https://www.domain.com/?query=value
    )
    valid_urls.each do |url|
      it "should allow url to be set to \"#{url}\"", :vcr do
        should allow_value(url).for(:url)
      end
    end
  end
end
