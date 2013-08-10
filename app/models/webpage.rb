# == Schema Information
#
# Table name: webpages
#
#  id            :integer          not null, primary key
#  effective_url :string(255)      default(""), not null
#  primary_ip    :string(255)
#  body          :text(2147483647)
#  created_at    :datetime
#  updated_at    :datetime
#

class Webpage < ActiveRecord::Base
  has_one :screenshot, dependent: :destroy
  has_many :webpage_responses, dependent: :destroy
  has_many :webpage_requests,  through: :webpage_responses

  validates :effective_url, presence: true, format: URI.regexp(%w(http https))
  validates :effective_url, uniqueness: { case_sensitive: false }

  after_create :create_screenshot!
end
