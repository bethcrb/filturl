# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(2000)     not null
#  slug       :string(255)
#  status     :string(255)      default("new")
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_webpage_requests_on_slug             (slug) UNIQUE
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

  describe 'respond_to' do
    it { is_expected.to respond_to(:headers) }
    it { is_expected.to respond_to(:redirect_count) }
    it { is_expected.to respond_to(:body) }
    it { is_expected.to respond_to(:location) }
    it { is_expected.to respond_to(:primary_ip) }
    it { is_expected.to respond_to(:webpage_url) }
    it { is_expected.to respond_to(:screenshot_url) }
  end

  describe '#normalize_friendly_id' do
    context 'when the url is longer than 255 characters' do
      subject(:webpage_request) { create(:webpage_request, :lengthy_url) }
      it 'shortens the slug to 255 characters' do
        expect(webpage_request.slug.length).to eq(255)
      end

      it 'uses the first 228 and the last 25 characters of the URL' do
        url = webpage_request.url.parameterize
        expect(webpage_request.slug).to eq("#{url[0..227]}--#{url[-25..-1]}")
      end
    end

    context 'when the url is less than 255 characters' do
      subject(:webpage_request) { create(:webpage_request) }
      it 'uses the parameterized url as the slug' do
        expect(webpage_request.slug).to eq(webpage_request.url.parameterize)
      end
    end
  end

  describe '#slug_candidates' do
    context 'when the slug already exists' do
      let(:first_user) { create(:user) }
      let(:second_user) { create(:user) }
      let(:first_request) { create(:webpage_request, user: first_user) }
      subject(:webpage_request) { create(:webpage_request, user: second_user) }

      it 'uses the parameterized url and the user_id as the slug' do
        new_slug = "#{first_request.url.parameterize}-#{second_user.id}"
        expect(webpage_request.slug).to eq(new_slug)
      end
    end
  end
end
