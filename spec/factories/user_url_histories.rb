# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_url_history do
    url 'http://www.google.com/'
    last_requested_at Time.now
    webpage
    user
  end
end
