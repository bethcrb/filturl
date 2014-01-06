require 'spec_helper'

describe WebpageRequestsController do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe "GET 'index'" do
    before(:each) do
      get :index
    end

    it 'assigns @webpage_request to a new WebpageRequest' do
      get :index
      expect(assigns(:webpage_request)).to be_a_new(WebpageRequest)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe "POST 'create'" do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    context 'when the webpage request is successful', :vcr do
      let(:webpage_request_params) do
        { url: 'http://www.yahoo.com/', user_id: user.id }
      end

      it 'redirects to the webpage results' do
        post :create, webpage_request: webpage_request_params
        webpage_request = WebpageRequest.find_by(webpage_request_params)
        expect(response).to redirect_to(webpage_request.webpage)
      end
    end

    context 'when the webpage request is not successful', :vcr do
      let(:bad_webpage_request_params) do
        { url: 'http://not.a.valid.url/', user_id: user.id }
      end

      it 'renders the index template when there is an error' do
        post :create, webpage_request: bad_webpage_request_params
        expect(response).to render_template('index')
      end
    end
  end
end
