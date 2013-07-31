# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage do
    effective_url "http://www.google.com/"
    primary_ip "74.125.239.114"
    body "<html><head></head><body>MyText</body></html>"
  end
end
