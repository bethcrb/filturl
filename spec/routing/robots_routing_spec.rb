require 'spec_helper'

describe RobotsController do
  describe 'routing' do
    it 'routes /robots.txt to robots#show via get' do
      expect(get('/robots.txt')).to route_to('robots#show')
    end
  end
end
