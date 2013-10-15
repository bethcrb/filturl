require 'spec_helper'

describe WebpageRequestsController do
  include_context 'skip screenshot callbacks'

  describe 'routing' do

    it 'routes / to webpage_requests#index via get' do
      get('/').should route_to('webpage_requests#index')
    end

    it 'routes /robots.txt to webpage_requests#robots via get' do
      get('/robots.txt').should route_to('webpage_requests#robots')
    end

    it 'routes /urls/request to webpage_requests#create via post' do
      post('/').should route_to('webpage_requests#create')
    end

  end
end
