require 'spec_helper'

describe WebpageRequestsController do
  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user

    @attr = {
      :url     => "http://www.example.com",
      :user_id => user.id,
    }
  end

  describe "GET 'show'", :vcr => { cassette_name: "http_www_google_com" } do
    let (:webpage_request) { FactoryGirl.create(:webpage_request) }
    it "shows the webpage request" do
      get :show, :id => webpage_request.id
      assigns(:webpage_request).should == webpage_request
    end
  end

  describe "POST 'create'", :vcr => { cassette_name: "http_www_example_com" } do
    it "creates a new webpage request" do
      post :create, {:webpage_request => @attr}
      assigns(:webpage_request).should be_a(WebpageRequest)
    end

    it "redirects to the webpage request" do
      post :create, {:webpage_request => @attr}
      response.should redirect_to(WebpageRequest.last)
    end
  end
end
