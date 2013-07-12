require 'spec_helper'

describe WebpageRequestsController do
  before (:each) do
    @user = FactoryGirl.create(:user)
    sign_in @user

    @webpage_request = FactoryGirl.create(:webpage_request)
  end

  describe "GET 'show'" do
    it "shows the webpage request" do
      pending
    end
  end

  describe "POST 'create'" do
    it "creates a new webpage request" do
      pending
    end

    it "redirects to the webpage request" do
      pending
    end
  end
end
