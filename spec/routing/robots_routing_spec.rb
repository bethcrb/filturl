require 'spec_helper'

describe RobotsController do
  describe 'routing' do
    it 'routes /robots.txt to robots#show via get' do
      get('/robots.txt').should route_to('robots#show')
    end
  end
end
