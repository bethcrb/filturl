# This validator validates URLs by attempting to resolve their hostname
# to a valid IP address.
class UrlValidator < ActiveModel::Validator
  def validate(record)
    uri = URI.parse(record.url)
    host = uri.host
    ip_address = Resolv.getaddress(host)
    if ip_address == '0.0.0.0'
      record.errors[:url] << 'could not be resolved to a valid IP address'
    end
  rescue => error
    record.errors[:url] << "returned an error (#{error.message})"
  end
end
