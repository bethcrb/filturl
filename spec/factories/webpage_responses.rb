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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_response do
    redirect_count 0
    code 200
    headers 'HTTP/1.1 200 OK'
    webpage_request
    webpage
  end
end
