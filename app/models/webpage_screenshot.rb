# == Schema Information
#
# Table name: webpage_screenshots
#
#  id                  :integer          not null, primary key
#  filename            :string(255)
#  webpage_response_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

class WebpageScreenshot < ActiveRecord::Base
  belongs_to :webpage_response
end
