require 'spec_helper'

describe WebpageRequestsController do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe 'routing' do

    it 'routes / to webpage_requests#index via get' do
      expect(get('/')).to route_to('webpage_requests#index')
    end

    it 'routes /urls/request to webpage_requests#create via post' do
      expect(post('/')).to route_to('webpage_requests#create')
    end

  end
end
