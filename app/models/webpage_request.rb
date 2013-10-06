# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(255)      not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class WebpageRequest < ActiveRecord::Base
  belongs_to :user

  has_one :webpage_response, dependent: :destroy
  has_one :webpage, through: :webpage_response
  has_one :screenshot, through: :webpage

  before_validation :clean_url

  validates :user, presence: true
  validates :url, presence: true, format: URI.regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false, scope: :user_id }
  validates_each :url do |record, attr, value|
    if value =~ URI.regexp(%w(http https))
      begin
        response = Typhoeus.get(value, followlocation: true,
          ssl_verifypeer: false)
        if response.headers.empty?
          message = response.return_message
          record.errors[attr] << "is not reachable (#{message})"
        else
          content_type = response.headers['Content-Type']
          unless content_type.present? && content_type =~ /^text\/html/
            record.errors[attr] << 'could not be verified as HTML'
          end
        end
      rescue => e
        record.errors[attr] << "returned an error (#{e.message})"
      end
    end
  end

  after_create :create_webpage_response!

  def clean_url
    self.url = PostRank::URI.clean(url).to_s unless url.blank?
  end
end
