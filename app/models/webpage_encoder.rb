# The WebpageEncoder class is for encoding the webpage body in UTF-8
# before it is saved.
class WebpageEncoder
  attr_accessor :webpage

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

  def initialize(webpage)
    @webpage = webpage
  end

  # Convenience method for returning the content type
  def content_type
    @webpage.content_type
  end

  # Returns the MIME type of this webpage based on its Content-Type header.
  def mime_type
    MIME::Types[content_type] && MIME::Types[content_type].first
  end

  # Returns true or false based on whether or not the MIME type is allowed.
  def mime_type_allowed?
    return false unless mime_type
    mime_type.ascii? && ALLOWED_MIME_TYPES.include?(mime_type)
  end

  # Set the meta encoding of this page as according to Nokogiri. In the event
  # that Nokogiri does not find one, default to ISO-8859-1 unless the content
  # is UTF-8.
  def set_meta_encoding
    return unless @webpage.body
    @webpage.meta_encoding = Nokogiri::HTML(@webpage.body).meta_encoding
    @webpage.meta_encoding ||= @webpage.body.is_utf8? ? 'UTF-8' : 'ISO-8859-1'
  end

  # Returns the body encoded in UTF-8 based on the MIME type and meta encoding.
  # In the event that the webpage does not use an allowed MIME type, returns
  # the body as nil. If the body is already encoded as UTF-8, returns the body
  # as is.
  def encoded_body
    return unless @webpage.body

    set_meta_encoding
    return nil unless mime_type_allowed?

    content = @webpage.body
    unless content.is_utf8?
      encoding_options = { invalid: :replace, undef: :replace, replace: '' }
      content.encode!('UTF-8', @webpage.meta_encoding, encoding_options)
    end

    content
  end
end
