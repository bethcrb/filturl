require 'rails_helper'

RSpec.describe WebpageRequestsController, type: :controller do
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

  describe "GET 'show'", :vcr do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    context 'the current user made the webpage request' do
      let(:existing_webpage_request) do
        create(:webpage_request, user: user, perform_http_request: true)
      end

      before(:each) { get :show, id: existing_webpage_request.slug }

      it 'renders the show template' do
        expect(response).to render_template('show')
      end

      it 'assigns @webpage_request' do
        expect(assigns(:webpage_request)).to eq(existing_webpage_request)
      end
    end

    context 'the current user did not make the webpage request' do
      let(:other_user) { create(:user) }
      let(:other_webpage_request) do
        create(:webpage_request, user: other_user, perform_http_request: true)
      end

      it 'renders the show template' do
        get :show, id: other_webpage_request.slug
        expect(response).to render_template('show')
      end
    end

    context 'the webpage does not exist' do
      it 'redirects to the root url' do
        get :show, id: 'http-www-notfound-com'
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe "POST 'create'", :vcr do
    let(:user) { FactoryGirl.create(:user) }
    before { sign_in user }

    context 'when the webpage request is successful' do
      let(:webpage_request_params) do
        { url: 'http://www.yahoo.com/', user_id: user.id }
      end

      it 'redirects to the webpage request results' do
        post :create, webpage_request: webpage_request_params
        webpage_request = WebpageRequest.find_by(webpage_request_params)
        expect(response).to redirect_to(webpage_request)
      end
    end

    context 'when the webpage request is not successful' do
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
