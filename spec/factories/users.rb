FactoryGirl.define do
  factory :user do
    sequence(:name) {|n| "John Doe ##{n}" }
    sequence(:email) {|n| "example_user#{n}@example.com" }
    sequence(:username) {|n| "example_user#{n}" }
    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now

    factory :admin do
      after(:create) {|user| user.add_role(:admin)}
    end
  end
end
