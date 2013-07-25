# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_response do
    effective_url "http://www.google.com/"
    primary_ip "74.125.239.114"
    redirect_count 0
    body "<html><head></head><body>MyText</body></html>"
    code 200
    headers "HTTP/1.1 200 OK"
    webpage_request
  end
end
