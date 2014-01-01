# == Schema Information
#
# Table name: webpages
#
#  id         :integer          not null, primary key
#  url        :string(2000)     default(""), not null
#  slug       :string(255)
#  primary_ip :string(255)
#  body       :text(2147483647)
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_webpages_on_slug  (slug) UNIQUE
#

class Webpage < ActiveRecord::Base
  extend FriendlyId

  has_one :screenshot, dependent: :destroy
  has_many :url_histories, dependent: :destroy
  has_many :webpage_responses, dependent: :destroy
  has_many :webpage_requests,  through: :webpage_responses

  validates :url, presence: true, format: URI.regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false }
  validates :url, length: { maximum: 2000 }

  after_create :create_screenshot!

  friendly_id :url, use: :slugged

  def location
    @location ||= WebpageLocation.new(self)
  end
end
