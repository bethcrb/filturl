require 'spec_helper'

describe WebpageRequestsController do
  include_context 'skip screenshot callbacks'

  describe 'routing' do

    it 'routes / to webpage_requests#index via get' do
      get('/').should route_to('webpage_requests#index')
    end

    it 'routes /urls/request to webpage_requests#create via post' do
      post('/urls/request').should route_to('webpage_requests#create')
    end

  end
end
