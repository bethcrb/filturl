require 'spec_helper'

describe 'WebpageService', vcr: { cassette_name: 'WebpageService' } do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  before(:each) do
    VCR.use_cassette('WebpageRequest/create') do
      @webpage_request = create(:webpage_request, perform_http_request: true)
    end
  end

  describe '.new' do
    it 'returns the WebpageService object' do
      webpage_service = WebpageService.new(@webpage_request)
      expect(webpage_service).to be_a(WebpageService)
    end
  end

  describe '.perform_http_request' do
    it 'returns a Typhoeus::Response' do
      response = WebpageService.perform_http_request(@webpage_request)
      expect(response).to be_a(Typhoeus::Response)
    end
  end

  describe '#perform_http_request' do
    let(:webpage_service) { WebpageService.new(@webpage_request) }
    before(:each) { webpage_service.perform_http_request }

    it 'returns a Typhoeus::Response' do
      expect(webpage_service.response).to be_a(Typhoeus::Response)
    end

    it 'saves the webpage response' do
      expect(webpage_service.webpage_response).to be_a(WebpageResponse)
    end

    it 'saves the webpage' do
      expect(webpage_service.webpage).to be_a(Webpage)
    end

    it 'sets the webpage_request status' do
      expect(@webpage_request.status).to_not eq('new')
    end
  end
end
