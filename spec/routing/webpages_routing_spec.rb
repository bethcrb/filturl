require 'rails_helper'

vcr_opts = { cassette_name: 'WebpageRequest/create' }

RSpec.describe WebpagesController, type: :routing, vcr: vcr_opts do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe 'routing' do
    it 'routes /urls/:id with slug to webpages#show' do
      webpage_request = FactoryGirl.create(
        :webpage_request,
        perform_http_request: true
      )
      expect(get("/urls/#{webpage_request.webpage.slug}")).to route_to(
        'webpages#show',
        id: webpage_request.webpage.slug
      )
    end

    it 'does not route /urls/:id with numeric id to webpages#show' do
      webpage_request = FactoryGirl.create(
        :webpage_request,
        perform_http_request: true
      )
      expect(get("/urls/#{webpage_request.webpage.id}")).not_to route_to(
        'webpages#show',
        id: webpage_request.webpage.id
      )
    end
  end
end
