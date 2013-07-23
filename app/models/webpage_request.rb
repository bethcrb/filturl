class WebpageRequest < ActiveRecord::Base
  extend FriendlyId

  belongs_to :user

  has_one :webpage_response, dependent: :destroy

  before_validation :clean_url

  validates :url, presence: true, format: URI::regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false, scope: :user_id }
  validates_each :url do |record, attr, value|
    begin
      if value =~ URI::regexp(%w(http https))
        response = Net::HTTP.get_response(URI(value))
      end
    rescue => e
      record.errors.add(attr, "must be a valid URL (#{e.message})")
    end
  end
  after_create :create_webpage_response!

  friendly_id :generate_short_code, :use => :slugged

  def clean_url
    self.url = PostRank::URI.clean(url).to_s unless url.blank?
  end

  def generate_short_code
    SecureRandom.urlsafe_base64(10).gsub(/[-_]/, "").sub(/^\d+/, "").slice(0, 6)
  end

  def should_generate_new_friendly_id?
    new_record?
  end

  def normalize_friendly_id(value)
    value.to_s
  end
end
