# The WebpageService class is for processing http requests.
class WebpageService
  attr_reader :response, :webpage, :webpage_request, :webpage_response

  def initialize(webpage_request)
    @webpage_request = webpage_request
    @response, @webpage, @webpage_response = nil
  end

  def self.get_url(webpage_request)
    WebpageService.new(webpage_request).get_url
  end
  
  # Performs a GET request on the request_url
  def get_url
    request_opts = { followlocation: true, ssl_verifypeer: false }
    @response = Typhoeus.get(@webpage_request.url, request_opts)
    @response && process_response_data
    @response
  end

  private

  # Saves response data corresponding to WebpageRequest, WebpageResponse,
  # Webpage and WebpageRedirect
  def process_response_data
    return unless @response
    save_webpage_response
    save_webpage
    save_webpage_redirects
  end

  # Updates or creates the Webpage record for webpage_url with data from
  # @response
  def save_webpage
    @webpage = Webpage.find_or_initialize_by(url: webpage_url)
    @webpage.update(
      body:         response_body,
      content_type: content_type,
      primary_ip:   primary_ip,
    )
  end
  
  # Creates the WebpageResponse record with data from @response
  def save_webpage_response
    save_webpage unless @webpage
    @webpage_response = @webpage_request.create_webpage_response!(
      code:           response_code,
      headers:        response_headers,
      redirect_count: redirections.size,
      webpage_id:     @webpage.id,
    )
  end
  
  # Creates new webpage redirects based on Location headers
  def save_webpage_redirects
    redirections.each do |redirection|
      redirect_url = redirection.headers[:location]
      @webpage_response.webpage_redirects.find_or_create_by!(url: redirect_url)
    end
  end

  # Convenience methods for response returned by get_url
  def webpage_url
    @response.effective_url || @webpage_request.url
  end
  
  def primary_ip
    @response.primary_ip
  end
  
  def response_body
    @response.response_body
  end
  
  def content_type
    @response.headers['Content-Type']
  end
  
  def response_code
    @response.response_code
  end
  
  def response_headers
    @response.response_headers
  end
  
  def redirections
    @response.redirections
  end
end
