# Read about factories at https://github.com/thoughtbot/factory_girl

require File.expand_path('../../../features/support/omniauth',  __FILE__)

FactoryGirl.define do
  auth_uid = Random.rand(10**21).to_s

  factory :authentication do
    provider 'facebook'
    uid auth_uid
    name { "#{first_name} #{last_name}" }
    email { Faker::Internet.email(name) }
    nickname { Faker::Internet.user_name(name) }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    image "http://graph.facebook.com/#{auth_uid}/picture?type=square"
    raw_info OmniAuth.config.mock_auth[:facebook]
    user nil
  end
end
