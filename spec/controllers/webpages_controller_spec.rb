require 'spec_helper'

describe WebpagesController do
  include_context 'skip screenshot callbacks'

  let(:user) { FactoryGirl.create(:user) }

  before do
    sign_in user
  end

  describe "GET 'show'" do
    let (:webpage) { FactoryGirl.create(:webpage) }
    it 'shows the webpage', :vcr do
      get :show, id: webpage.id
      response.should be_success
    end
  end

end
