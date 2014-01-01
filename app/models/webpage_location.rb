# The WebpageLocation class is for determining information about a webpage's
# location based on its IP address.
class WebpageLocation
  def initialize(webpage)
    return '' unless webpage && webpage.primary_ip
    @geoip2 = GeoIP2::locate(webpage.primary_ip)
  end

  def city
    @geoip2 && @geoip2['city']
  end

  def state
    @geoip2 && @geoip2['subdivision_code']
  end

  def country
    @geoip2 && @geoip2['country']
  end

  def to_s
    [city, state, country].reject(&:blank?).join(', ')
  end
end
