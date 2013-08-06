require 'spec_helper'

describe HomeController do
  before (:each) do
    @user = FactoryGirl.create(:user)
  end

  describe "GET 'index'" do
    context 'when user is logged in' do
      before (:each) do
        sign_in @user
      end

      it 'should be successful' do
        get 'index'
        response.should be_success
      end
    end

    context 'when user is not logged in' do
      it 'should redirect to sign in page' do
        get 'index'
        response.should redirect_to(new_user_session_path)
      end
    end
  end
end
