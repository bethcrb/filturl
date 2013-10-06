# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_request do
    url 'http://www.google.com/'
    user
  end
end
