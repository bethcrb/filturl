require 'spec_helper'

describe WebpageService, vcr: { cassette_name: 'WebpageRequest/create' } do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  describe '.new' do
    let(:webpage_request) { build(:webpage_request) }
    it 'returns the WebpageService object' do
      webpage_service = WebpageService.new(webpage_request)
      expect(webpage_service).to be_a(WebpageService)
    end
  end

  describe '.perform_http_request' do
    let(:webpage_request) { build(:webpage_request) }
    it 'returns a Typhoeus::Response' do
      response = WebpageService.perform_http_request(webpage_request)
      expect(response).to be_a(Typhoeus::Response)
    end
  end

  describe '#perform_http_request' do
    let(:webpage_request) { create(:webpage_request) }
    let(:webpage_service) { WebpageService.new(webpage_request) }

    context 'when it is successful' do
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

      it 'sets the webpage_request status to "complete"' do
        expect(webpage_request.status).to eq('complete')
      end
    end

    context 'when save_webpage fails' do
      it 'sets the webpage_request status to "error"' do
        webpage_service.stub(:save_webpage).and_return(false)
        webpage_service.perform_http_request
        expect(webpage_request.status).to eq('error')
      end
    end

    context 'when there are redirects' do
      let(:redirect_response) do
        Typhoeus::Response.new(response_headers: 'Location: http://localhost/')
      end

      it 'saves the redirects' do
        webpage_service.stub(:redirections).and_return([redirect_response])
        webpage_service.perform_http_request

        webpage_redirects = webpage_request.webpage_response.webpage_redirects
        expect(webpage_redirects.size).to eq(1)
        expect(webpage_redirects.first.url).to eq('http://localhost/')
      end
    end
  end
end
