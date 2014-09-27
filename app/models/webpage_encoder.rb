# The WebpageEncoder class is for encoding the webpage body in UTF-8
# before it is saved.
class WebpageEncoder
  ALLOWED_MIME_TYPES = [
    'application/javascript',
    'application/json',
    'application/jsonrequest',
    'application/x-javascript',
    'application/x-xml',
    'application/x-yaml',
    'application/xhtml+xml',
    'application/xml',
    'text/css',
    'text/csv',
    'text/html',
    'text/javascript',
    'text/plain',
    'text/x-json',
    'text/xml',
    'text/yaml'
  ]

  attr_accessor :webpage

  delegate :body, :content_type, to: :webpage

  def initialize(webpage)
    @webpage = webpage
  end

  # Returns the MIME type of this webpage based on its Content-Type header.
  def mime_type
    MIME::Types[content_type].shift
  end

  # Returns true or false based on whether or not the MIME type is allowed.
  def mime_type_allowed?
    return false unless mime_type
    ALLOWED_MIME_TYPES.include?(mime_type)
  end

  # Set the meta encoding of this page as according to Nokogiri. In the event
  # that Nokogiri does not find one, default to ISO-8859-1 unless the content
  # is UTF-8.
  def set_meta_encoding
    return unless body
    webpage.meta_encoding = Nokogiri::HTML(body).meta_encoding
    webpage.meta_encoding ||= body.is_utf8? ? 'UTF-8' : 'ISO-8859-1'
  end

  # Returns the body encoded in UTF-8 based on the MIME type and meta encoding.
  # In the event that the webpage does not use an allowed MIME type, returns
  # the body as nil. If the body is already encoded as UTF-8, returns the body
  # as is.
  def encoded_body
    return unless body

    set_meta_encoding
    return nil unless mime_type_allowed?

    content = body
    unless content.is_utf8?
      encoding_options = { invalid: :replace, undef: :replace, replace: '' }
      content.encode!('UTF-8', webpage.meta_encoding, encoding_options)
    end

    content
  end
end
