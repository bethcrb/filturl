require 'spec_helper'

describe RobotsController do
  describe "GET '/robots.txt'" do
    it 'outputs the contents of the robots.txt file' do
      get :show
      expect(response.content_type).to eq('text/plain')
    end
  end
end
