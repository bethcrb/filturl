require 'webmock/cucumber'

WebMock.stub_request(:any, "http://www.unknown_response.com").to_raise(
  Net::HTTPUnknownResponse.new("", 0, "")
)

WebMock.allow_net_connect!
