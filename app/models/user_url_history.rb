class UserUrlHistory < ActiveRecord::Base
  belongs_to :webpage
  belongs_to :user

  validates :url, presence: true, format: URI.regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :last_requested_at, presence: true
  validates :webpage, presence: true
  validates :user, presence: true
end
