# == Schema Information
#
# Table name: url_histories
#
#  id         :integer          not null, primary key
#  url        :string(2000)
#  webpage_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class UrlHistory < ActiveRecord::Base
  belongs_to :webpage
  belongs_to :user

  validates :url, presence: true, format: URI.regexp(%w(http https))
  validates :url, length: { maximum: 2000 }
  validates :webpage, presence: true
  validates :user, presence: true
end
