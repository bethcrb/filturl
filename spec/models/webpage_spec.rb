require 'spec_helper'

describe Webpage do

  before(:each) do
    @attr = {
      :url => "http://www.example.com",
    }
  end

  it "should create a new instance given a valid attribute" do
    Webpage.create!(@attr)
  end

  describe "urls"
    it "should require a url" do
      no_url_webpage = Webpage.new(@attr.merge(:url => ""))
      no_url_webpage.should_not be_valid
    end

    it "should reject duplicate urls" do
      Webpage.create!(@attr)
      webpage_with_duplicate_url = Webpage.new(@attr)
      webpage_with_duplicate_url.should_not be_valid
    end

    it "should reject invalid urls" do
      urls = %w[www.domain.com htt://www.$example.com httptest]
      urls.each do |url|
        invalid_url_webpage = Webpage.new(@attr.merge(:url => url))
        invalid_url_webpage.should_not be_valid
      end
    end

    it "should reject urls that do not begin with http or https" do
      urls = %w[file://example.doc ftp://ftp.test.com gopher://domain.com]
      urls.each do |url|
        invalid_url_webpage = Webpage.new(@attr.merge(:url => url))
        invalid_url_webpage.should_not be_valid
      end
    end

    it "should accept valid urls" do
      urls = %w[http://www.example.com http://www.test.com/page.html#anchor https://www.domain.com/?query=value]
      urls.each do |url|
        valid_url_webpage = Webpage.new(@attr.merge(:url => url))
        valid_url_webpage.should be_valid
      end
    end

end
