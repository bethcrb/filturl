# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(255)      not null
#  slug       :string(255)
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class WebpageRequest < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_one :webpage_response, dependent: :destroy
  has_one :webpage_screenshot, through: :webpage_response

  before_validation :clean_url

  validates :user, presence: true
  validates :url, presence: true, format: URI::regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false, scope: :user_id }
  validates_each :url do |record, attr, value|
    if value =~ URI::regexp(%w(http https))
      begin
        response = Typhoeus.get(value,
          followlocation: true,
          ssl_verifypeer: false,
        )
        if response.code == 0
          return_message = response.return_message
          record.errors.add(attr, "must be reachable (#{return_message})")
        end
      rescue => e
        record.errors.add(attr, "must be a valid URL (#{e.message})")
      end
    end
  end

  after_create :create_webpage_response!

  friendly_id :user_url, :use => :slugged

  def clean_url
    self.url = PostRank::URI.clean(url).to_s unless url.blank?
  end

  def user_url
    "#{url.gsub(/\W+/, '-').sub(/-$/, '')}-#{user_id}" unless url.blank?
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def normalize_friendly_id(value)
    value.to_s
  end
end
