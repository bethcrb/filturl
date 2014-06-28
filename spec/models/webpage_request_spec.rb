# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(2000)     not null
#  status     :string(255)      default("new")
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_webpage_requests_on_url_and_user_id  (url,user_id)
#

require 'rails_helper'

RSpec.describe WebpageRequest, type: :model do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_one(:webpage_response).dependent(:destroy) }
    it { is_expected.to have_one(:webpage).through(:webpage_response) }
    it { is_expected.to have_one(:screenshot).through(:webpage) }
    it { is_expected.to have_many(:webpage_redirects).through(:webpage_response) }
  end

  describe 'before validation' do
    subject { build_stubbed(:webpage_request, url: 'www.example.com') }

    it 'cleans the url' do
      subject.valid?
      expect(subject.url).to eq('http://www.example.com/')
    end
  end

  describe 'validations' do
    subject { build(:webpage_request, perform_http_request: true) }

    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to ensure_length_of(:url).is_at_most(2000) }

    it 'requires unique value for url scoped to user_id' do
      subject.save!
      is_expected.to validate_uniqueness_of(:url).scoped_to(:user_id)
    end

    invalid_urls = %w(
      file://example.doc
      ftp://ftp.test.com
      gopher://domain.com
      htt://www.$example.com
      httptest
      http://not.a.valid.url/
      http://www.unknown_response.com/
      http://0.0.0.0/
    )
    invalid_urls.each do |url|
      it "does not allow url to be set to \"#{url}\"" do
        is_expected.not_to allow_value(url).for(:url)
      end
    end

    valid_urls = %w(
      http://www.example.com
      http://www.microsoft.com/page.html#anchor
      https://www.domain.com/?query=value
    )
    valid_urls.each do |url|
      it "allows url to be set to \"#{url}\"" do
        is_expected.to allow_value(url).for(:url)
      end
    end
  end
end
