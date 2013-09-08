class Webpage < ActiveRecord::Base
  has_one :screenshot, dependent: :destroy
  has_many :user_url_histories, dependent: :destroy
  has_many :webpage_responses, dependent: :destroy
  has_many :webpage_requests,  through: :webpage_responses

  validates :url, presence: true, format: URI.regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false }

  after_create :create_screenshot!
end
