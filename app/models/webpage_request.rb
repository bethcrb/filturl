class WebpageRequest < ActiveRecord::Base
  belongs_to :user

  has_one :webpage_response, dependent: :destroy

  before_validation :clean_url

  validates :url, presence: true, uniqueness: true, format: URI::regexp(%w(http https))

  after_create :create_webpage_response!

  def clean_url
    self.url = PostRank::URI.clean(url).to_s unless url.blank?
  end
end
