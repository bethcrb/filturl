# The WebpageLocation class is for determing information about a webpage's
# location based on its IP address.
class WebpageLocation
  def initialize(webpage)
    @geocoder = Geocoder.search(webpage.primary_ip).first
  end

  def city
    @geocoder.city
  end

  def state_code
    @geocoder.state_code
  end

  def country
    @geocoder.country
  end

  def to_s
    [city, state_code, country].reject(&:empty?).join(', ')
  end
end
