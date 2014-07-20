require 'rails_helper'

vcr_opts = { cassette_name: 'WebpageRequest/create' }

RSpec.describe WebpageRequestsController, type: :routing, vcr: vcr_opts do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe 'routing' do

    it 'routes / to webpage_requests#new via get' do
      expect(get('/')).to route_to(
        controller: 'webpage_requests',
        action: 'new'
      )
    end

    it 'routes / to webpage_requests#create via post' do
      expect(post('/')).to route_to(
        controller: 'webpage_requests',
        action: 'create'
      )
    end

    it 'routes /urls/:id with slug to webpage_requests#show' do
      webpage_request = FactoryGirl.create(
        :webpage_request,
        perform_http_request: true
      )
      expect(get("/urls/#{webpage_request.slug}")).to route_to(
        controller: 'webpage_requests',
        action: 'show',
        id: webpage_request.slug
      )
    end

    it 'does not route /urls/:id with numeric id to webpage_requests#show' do
      webpage_request = FactoryGirl.create(
        :webpage_request,
        perform_http_request: true
      )

      expect(get("/urls/#{webpage_request.id}")).not_to route_to(
        controller: 'webpage_requests',
        action: 'show',
        id: webpage_request.id.to_s
      )
    end

  end
end
