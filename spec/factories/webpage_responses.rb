# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_response do
    app_connect_time 0.000036
    connect_time 0.000036
    effective_url "http://www.google.com/"
    httpauth_avail false
    name_lookup_time 0.000035
    pretransfer_time 0.000291
    primary_ip "74.125.239.114"
    redirect_count 0
    body "<html><head></head><body>MyText</body></html>"
    code 200
    headers "HTTP/1.1 200 OK"
    return_message "No error"
    start_transfer_time 1.5
    total_time 1.5
    webpage_request nil
  end
end
