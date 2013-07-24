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

require 'spec_helper'

describe WebpageScreenshot do
  pending "add some examples to (or delete) #{__FILE__}"
end
