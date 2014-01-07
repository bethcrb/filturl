# This validator validates URLs by performing a HEAD request.
class UrlValidator < ActiveModel::Validator
  def validate(record)
    return unless record.url =~ URI.regexp(%w(http https))

    begin
      response = Typhoeus.head(record.url,
                               ssl_verifyhost: 0,
                               ssl_verifypeer: false,
                               timeout: 15)
      if response.headers.empty? || response.code == 0
        message = response.return_message
        record.errors[:url] << "could not be verified (#{message})"
      end
    rescue => error
      record.errors[:url] << "returned an error (#{error.message})"
    end
  end
end
