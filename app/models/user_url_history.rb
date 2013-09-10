# == Schema Information
#
# Table name: user_url_histories
#
#  id                :integer          not null, primary key
#  url               :string(500)
#  last_requested_at :datetime
#  webpage_id        :integer
#  user_id           :integer
#  created_at        :datetime
#  updated_at        :datetime
#

class UserUrlHistory < ActiveRecord::Base
  belongs_to :webpage
  belongs_to :user

  validates :url, presence: true, format: URI.regexp(%w(http https))
  validates :url, uniqueness: { case_sensitive: false, scope: :user_id }
  validates :last_requested_at, presence: true
  validates :webpage, presence: true
  validates :user, presence: true
end
