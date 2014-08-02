# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(2000)     not null
#  slug       :string(255)
#  status     :string(255)      default("new")
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_webpage_requests_on_slug             (slug) UNIQUE
#  index_webpage_requests_on_url_and_user_id  (url,user_id)
#

class WebpageRequest < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user, inverse_of: :webpage_requests

  has_one :webpage_response, dependent: :destroy
  has_one :webpage, through: :webpage_response
  has_one :screenshot, through: :webpage
  has_many :webpage_redirects, through: :webpage_response

  before_validation :clean_url

  validates :user, presence: true
  validates :url, presence: true
  validates :url, format: URI.regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :url, length: { maximum: 2000 }
  validates_with UrlValidator

  delegate :headers, :redirect_count, to: :webpage_response, allow_nil: true
  delegate :body, :location, :primary_ip, to: :webpage, allow_nil: true
  delegate :url, to: :webpage, prefix: true, allow_nil: true
  delegate :url, to: :screenshot, prefix: true, allow_nil: true

  friendly_id :slug_candidates, use: :slugged

  # Use the first 228 and the last 25 characters to construct the slug when it
  # is longer than 255 characters
  def normalize_friendly_id(string)
    super.length > 255 ? "#{super[0..227]}--#{super[-25..-1]}" : super
  end

  def slug_candidates
    [
      :url,
      [:url, :user_id]
    ]
  end

  private

  def clean_url
    self.url = PostRank::URI.clean(url).to_s unless url.blank?
  end
end
