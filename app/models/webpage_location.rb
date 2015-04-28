# The WebpageLocation class is responsible for determining a webpage's location
# based on its IP address.
class WebpageLocation
  attr_reader :webpage

  alias_attribute :state, :subdivision_code

  def initialize(webpage)
    @webpage = webpage
  end

  def primary_ip
    webpage && webpage.primary_ip
  end

  def geolocation
    return nil unless primary_ip
    location = MaxmindGeoIP2.locate(primary_ip)
    location && location.symbolize_keys
  end

  def city
    super
  end

  def country
    super
  end

  def to_s
    return '' unless geolocation
    [city, state, country].reject(&:blank?).join(', ')
  end

  def method_missing(name, *args, &block)
    if args.empty? && !block && geolocation && geolocation.key?(name)
      geolocation[name]
    else
      super
    end
  end

  def respond_to?(method)
    if geolocation && geolocation.key?(method)
      true
    else
      super
    end
  end
end
