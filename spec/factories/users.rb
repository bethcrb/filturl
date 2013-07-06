FactoryGirl.define do
  factory :user, aliases: [:requestor] do
    name 'Test User'
    email 'example@example.com'
    password 'changeme'
    password_confirmation 'changeme'
    confirmed_at Time.now
  end
end
