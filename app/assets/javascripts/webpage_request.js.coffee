class WebpageRequest
  constructor: (url) ->
    @url = url
    return false if @url is ''
    uri = new URI(@url)
    if uri.protocol() is ''
      # Default to http if a protocol is not present
      uri.protocol 'http'
      
      # Create a new URI object so that all normalizations get applied in one go
      @url = uri.normalize().toString()
      uri = new URI(@url)
    @url = uri.normalize().toString()

@WebpageRequest = WebpageRequest
