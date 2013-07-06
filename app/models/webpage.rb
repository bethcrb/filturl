class Webpage < ActiveRecord::Base
  validates :url, presence: true, uniqueness: true, format: URI::regexp(%w(http https))
end
