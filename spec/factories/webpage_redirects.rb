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
# Indexes
#
#  index_webpage_redirects_on_webpage_response_id  (webpage_response_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_redirect do
    url "http://www.redirect.com/"
    webpage_response nil
  end
end
