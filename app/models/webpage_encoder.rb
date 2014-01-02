# The WebpageEncoder class is for the encoding the body of a webpage before it
# is saved.
class WebpageEncoder
  attr_accessor :webpage

  def initialize(webpage)
    @webpage = webpage
  end

  # Find the mime type of this webpage based on its Content-Type header.
  def mime_type
    return unless @webpage.content_type
    MIME::Types[@webpage.content_type]
  end

  # Set the meta encoding of this page as according to Nokogiri. In the event
  # that Nokogiri does not find one, default to ISO-8859-1 unless the content
  # is UTF-8.
  def set_meta_encoding
    return unless @webpage.body
    @webpage.meta_encoding = Nokogiri::HTML(@webpage.body).meta_encoding
    @webpage.meta_encoding ||= @webpage.body.is_utf8? ? 'UTF-8' : 'ISO-8859-1'
  end

  # Returns the encoded body based on the mime type and meta encoding. In the
  # event that the mime type or meta encoding is not found, returns the body
  # as is.
  def encoded_body
    return unless @webpage.body

    set_meta_encoding
    content = @webpage.body
    if mime_type.present? && mime_type.first.ascii? && !content.is_utf8?
      content.encode!('UTF-8', @webpage.meta_encoding, invalid: :replace)
    end
    content
  end
end
