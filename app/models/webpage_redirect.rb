# == Schema Information
#
# Table name: webpage_redirects
#
#  id                  :integer          not null, primary key
#  url                 :string(2000)
#  webpage_response_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class WebpageRedirect < ActiveRecord::Base
  belongs_to :webpage_response

  validates :url, presence: true
  validates :url, length: { maximum: 2000 }
  validates :webpage_response, presence: true
end
