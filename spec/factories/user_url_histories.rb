# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_url_history do
    url 'http://www.google.com/'
    webpage
    user
  end
end
