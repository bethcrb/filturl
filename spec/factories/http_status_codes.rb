# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :http_status_code do
    value 500
    description 'Internal Server Error'
    reference '[RFC2616]'
  end
end
