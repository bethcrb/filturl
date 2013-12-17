describe 'WebpageRequest', ->
  it 'normalizes the URL', ->
    webpage_request = new WebpageRequest('example.com')
    expect(webpage_request.url).toBe('http://example.com/')
