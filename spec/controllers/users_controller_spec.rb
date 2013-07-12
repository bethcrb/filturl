require 'spec_helper'

describe UsersController do
  before (:each) do
    @admin = FactoryGirl.create(:admin)
    @user = FactoryGirl.create(:user)
    @other_user = FactoryGirl.create(:user)
    request.env["HTTP_REFERER"] = "previous_location" unless request.nil? or request.env.nil?
  end

  describe "GET 'index'" do
    context "as admin" do
      before (:each) do
        sign_in @admin
      end

      it "should be successful" do
        get :show, :id => @user.id
        response.should be_success
      end
    end

    context "as user" do
      before (:each) do
        sign_in @user
      end

      it "should not be successful" do
        get :show, :id => @user.id
        response.should_not be_success
      end
    end
  end

  describe "GET 'show'" do
    context "when logged in as admin" do
      before (:each) do
        sign_in @admin
      end

      it "should be successful" do
        get :show, :id => @user.id
        response.should be_success
      end

      it "should find the right user" do
        get :show, :id => @user.id
        assigns(:user).should == @user
      end
    end

    context "when logged in as user" do
      before (:each) do
        sign_in @user
      end

      it "should find the logged in user" do
        get :show, :id => @user.id
        assigns(:user).should == @user
      end

      it "should redirect to the previous page if they try to find a different user" do
        get :show, :id => @other_user.id
        response.should redirect_to("previous_location")
      end
    end
  end
end
