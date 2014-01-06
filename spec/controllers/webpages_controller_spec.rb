require 'spec_helper'

describe WebpagesController, vcr: { cassette_name: 'WebpagesController' } do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  let(:user) { create(:user) }
  before { sign_in user }

  describe "GET 'show'", :vcr do
    let(:existing_webpage_request) do
      create(:webpage_request, user: user)
    end
    let(:existing_webpage) { existing_webpage_request.webpage }
    let(:existing_webpage_response) do
      existing_webpage.webpage_responses.last
    end
    let(:existing_screenshot) { existing_webpage.screenshot }

    context 'the current user made the webpage request' do
      before(:each) { get :show, id: existing_webpage.slug }

      it 'renders the show template' do
        expect(response).to render_template('show')
      end

      it 'assigns @webpage' do
        expect(assigns(:webpage)).to eq(existing_webpage)
      end

      it 'assigns @webpage_request' do
        expect(assigns(:webpage_request)).to eq(existing_webpage_request)
      end

      it 'assigns @webpage_response' do
        expect(assigns(:webpage_response)).to eq(existing_webpage_response)
      end

      it 'assigns @screenshot' do
        expect(assigns(:screenshot)).to eq(existing_screenshot)
      end
    end

    context 'the current user did not make the webpage request' do
      let(:other_user) { create(:user) }
      let(:other_webpage_request) do
        create(:webpage_request, user: other_user)
      end
      let(:other_webpage) { other_webpage_request.webpage }

      it 'redirects to the root url' do
        get :show, id: other_webpage.slug
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
