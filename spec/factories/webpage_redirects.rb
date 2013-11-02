# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_redirect do
    url "http://www.redirect.com/"
    webpage_response nil
  end
end
