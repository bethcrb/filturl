# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_screenshot do
    url nil
    filename nil
    webpage
  end
end
