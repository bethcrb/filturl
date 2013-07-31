# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_response do
    redirect_count 0
    code 200
    headers "HTTP/1.1 200 OK"
    webpage_request
    webpage
  end
end
