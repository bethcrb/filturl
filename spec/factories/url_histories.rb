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
# Indexes
#
#  index_url_histories_on_user_id     (user_id)
#  index_url_histories_on_webpage_id  (webpage_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :url_history do
    url 'http://www.google.com/'
    webpage
    user
  end
end
