# == Schema Information
#
# Table name: screenshots
#
#  id         :integer          not null, primary key
#  filename   :string(255)
#  url        :string(2000)
#  status     :string(255)      default("new")
#  webpage_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_screenshots_on_webpage_id  (webpage_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :screenshot do
    url nil
    filename nil
    webpage
  end
end
