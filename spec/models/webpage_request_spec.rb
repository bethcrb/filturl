require 'spec_helper'
describe WebpageRequest do

  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = {
      :url     => "http://www.example.com",
      :user_id => @user.id,
    }
  end

  it "should create a new instance given a valid attribute", :vcr do
    WebpageRequest.create!(@attr)
  end

  it "should belong to a user", :vcr do
    user_webpage_request = WebpageRequest.create!(@attr)
    user_webpage_request.user.should == @user
  end

  describe "urls"
  it "should require a url" do
    no_url_webpage_request = WebpageRequest.new(@attr.merge(:url => ""))
    no_url_webpage_request.should_not be_valid
  end

  it "should reject duplicate urls", :vcr do
    WebpageRequest.create!(@attr)
    webpage_request_with_duplicate_url = WebpageRequest.new(@attr)
    webpage_request_with_duplicate_url.should_not be_valid
  end

  it "should reject invalid urls" do
    urls = %w[htt://www.$example.com httptest]
    urls.each do |url|
      invalid_url_webpage_request = WebpageRequest.new(@attr.merge(:url => url))
      invalid_url_webpage_request.should_not be_valid
    end
  end

  it "should reject urls that do not begin with http or https" do
    urls = %w[file://example.doc ftp://ftp.test.com gopher://domain.com]
    urls.each do |url|
      invalid_url_webpage_request = WebpageRequest.new(@attr.merge(:url => url))
      invalid_url_webpage_request.should_not be_valid
    end
  end

  it "should accept valid urls" do
    urls = %w[http://www.example.com http://www.test.com/page.html#anchor https://www.domain.com/?query=value]
    urls.each do |url|
      valid_url_webpage_request = WebpageRequest.new(@attr.merge(:url => url))
      valid_url_webpage_request.should be_valid
    end
  end
end
