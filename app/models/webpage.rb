# == Schema Information
#
# Table name: webpages
#
#  id            :integer          not null, primary key
#  url           :string(2000)     default(""), not null
#  primary_ip    :string(255)
#  body          :text(2147483647)
#  content_type  :string(255)
#  meta_encoding :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

class Webpage < ActiveRecord::Base
  has_one :screenshot, dependent: :destroy
  has_many :webpage_responses, dependent: :destroy
  has_many :webpage_requests,  through: :webpage_responses

  validates :url, presence: true, format: URI.regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false }
  validates :url, length: { maximum: 2000 }

  before_save :encode_body
  after_create :create_screenshot!

  def location
    WebpageLocation.new(self)
  end

  private

  # Before saving, prepare to encode the body as UTF-8.
  def encode_body
    return unless body

    encoded_body = WebpageEncoder.new(self).encoded_body
    self.body = encoded_body ? encoded_body.force_encoding('UTF-8') : nil
  end
end
