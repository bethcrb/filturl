FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    username { Faker::Internet.user_name }
    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now

    factory :admin do
      after(:create) { |user| user.add_role(:admin) }
    end
  end
end
