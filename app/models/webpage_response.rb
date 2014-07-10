# == Schema Information
#
# Table name: webpage_responses
#
#  id                 :integer          not null, primary key
#  redirect_count     :integer
#  code               :integer
#  headers            :text
#  webpage_request_id :integer
#  webpage_id         :integer
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_webpage_responses_on_webpage_id          (webpage_id)
#  index_webpage_responses_on_webpage_request_id  (webpage_request_id)
#

class WebpageResponse < ActiveRecord::Base
  belongs_to :webpage
  belongs_to :webpage_request, -> { includes :user }

  has_one :screenshot, through: :webpage
  has_many :webpage_redirects, dependent: :destroy

  validates :webpage_request, presence: true
end
