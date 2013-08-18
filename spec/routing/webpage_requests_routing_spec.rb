require 'spec_helper'

describe WebpageRequestsController do
  describe 'routing' do

    it 'routes / to webpage_requests#index via get' do
      get('/').should route_to('webpage_requests#index')
    end

    it 'routes /:id with slug to webpage_requests#show', :vcr do
      webpage_request = FactoryGirl.create(:webpage_request)
      get("/#{webpage_request.slug}").should route_to(
        'webpage_requests#show',
        id: webpage_request.slug
      )
    end

    it 'does not route /:id with numeric id to webpage_requests#show', :vcr do
      webpage_request = FactoryGirl.create(:webpage_request)
      get("/#{webpage_request.id}").should_not route_to(
        'webpage_requests#show',
        id: webpage_request.id
      )
    end

    it 'routes / to webpage_requests#create via post' do
      post('/').should route_to('webpage_requests#create')
    end

  end
end
