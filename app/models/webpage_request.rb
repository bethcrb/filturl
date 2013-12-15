# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(2000)     not null
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_webpage_requests_on_url_and_user_id  (url,user_id)
#

class WebpageRequest < ActiveRecord::Base
  belongs_to :user

  has_one :webpage_response, dependent: :destroy
  has_one :webpage, through: :webpage_response
  has_one :screenshot, through: :webpage

  before_validation :clean_url

  validates :user, presence: true
  validates :url, presence: true
  validates :url, format: URI.regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :url, length: { maximum: 2000 }
  validate  :verify_url

  after_create :create_webpage_response!
  after_save   :add_to_url_history

  private

  def clean_url
    self.url = PostRank::URI.clean(url).to_s unless url.blank?
  end

  def verify_url
    return unless url =~ URI.regexp(%w(http https))

    begin
      response = Typhoeus.head(url, {
        ssl_verifyhost: 0,
        ssl_verifypeer: false,
      })
      if response.headers.empty? || response.code == 0
        message = response.return_message
        errors.add(:url, "could not be verified (#{message})")
      end
    rescue => e
      errors.add(:url, "returned an error (#{e.message})")
    end
  end

  def add_to_url_history
    webpage.url_histories << UrlHistory.new(url:  url, user: user)
  end
end
