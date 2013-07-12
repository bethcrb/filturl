# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_response do
    app_connect_time 1.5
    connect_time 1.5
    effective_url "MyString"
    httpauth_avail false
    name_lookup_time 1.5
    pretransfer_time 1.5
    primary_ip "MyString"
    redirect_count 1
    response_body "MyText"
    response_code 1
    response_headers "MyText"
    return_code "MyString"
    return_message "MyString"
    start_transfer_time 1.5
    total_time 1.5
    webpage_request nil
  end
end
