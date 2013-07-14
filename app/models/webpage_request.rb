class WebpageRequest < ActiveRecord::Base
  belongs_to :requestor, class_name: "User"

  has_one :webpage_response, dependent: :destroy

  validates :url, presence: true, uniqueness: true, format: URI::regexp(%w(http https))
  after_create :create_webpage_response!
end
