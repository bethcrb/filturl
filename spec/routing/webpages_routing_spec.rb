require 'spec_helper'

describe WebpagesController do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe 'routing' do
    it 'routes /urls/:id with slug to webpages#show', :vcr do
      webpage_request = FactoryGirl.create(
        :webpage_request,
        perform_http_request: true
      )
      expect(get("/urls/#{webpage_request.webpage.slug}")).to route_to(
        'webpages#show',
        id: webpage_request.webpage.slug
      )
    end

    it 'does not route /urls/:id with numeric id to webpages#show', :vcr do
      webpage_request = FactoryGirl.create(
        :webpage_request,
        perform_http_request: true
      )
      expect(get("/urls/#{webpage_request.webpage.id}")).to_not route_to(
        'webpages#show',
        id: webpage_request.webpage.id
      )
    end
  end
end
