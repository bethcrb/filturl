require 'spec_helper'

describe WebpageRequestsController do
  include_context 'skip screenshot callbacks'

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user

    @attr = {
      url:     'http://www.yahoo.com',
      user_id: user.id,
    }
  end

  describe "POST 'create'" do
    it 'redirects to the webpage results', :vcr do
      post :create, { webpage_request: @attr }
      response.should redirect_to(WebpageRequest.last.webpage)
    end
  end
end
