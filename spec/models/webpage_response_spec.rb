# == Schema Information
#
# Table name: webpage_responses
#
#  id                 :integer          not null, primary key
#  effective_url      :string(255)
#  primary_ip         :string(255)
#  redirect_count     :integer
#  body               :text(2147483647)
#  code               :integer
#  headers            :text
#  webpage_request_id :integer
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe WebpageResponse do
  before(:each) do
    @webpage_response = FactoryGirl.create(:webpage_response)
    @attr = { webpage_request_id: @webpage_response.webpage_request_id }
  end

  it "respond_to", :vcr do
    @webpage_response.should respond_to(:primary_ip)
  end

  it "should create a new instance given valid attributes", :vcr do
    WebpageResponse.create!(@attr)
  end

  it "should belong to a webpage request", :vcr do
    no_webpage_request_response = WebpageResponse.new(@attr.merge(:webpage_request_id => nil))
    no_webpage_request_response.should_not be_valid
  end

  it "should update the response data after it is created", :vcr do
    original_response = WebpageResponse.create!(@attr.merge(code: -999))
    original_response.code.should_not == -999
  end

  describe "get_url" do
    it "should update the response data", :vcr do
      original_response = WebpageResponse.new(@attr.merge(code: -999))
      original_response.get_url
      original_response.code.should_not == -999
    end
  end
end
