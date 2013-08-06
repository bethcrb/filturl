# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication do
    provider 'MyString'
    uid 'MyString'
    name 'MyString'
    email 'MyString'
    nickname 'MyString'
    first_name 'MyString'
    last_name 'MyString'
    image 'MyString'
    raw_info 'MyText'
    user nil
  end
end
