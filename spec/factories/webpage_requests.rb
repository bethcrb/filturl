# == Schema Information
#
# Table name: webpage_requests
#
#  id         :integer          not null, primary key
#  url        :string(2000)     not null
#  slug       :string(255)
#  status     :string(255)      default("new")
#  user_id    :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_webpage_requests_on_slug             (slug) UNIQUE
#  index_webpage_requests_on_url_and_user_id  (url,user_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :webpage_request do
    ignore do
      perform_http_request false
    end

    url 'http://www.google.com/'
    slug nil
    user

    after(:create) do |webpage_request, evaluator|
      if evaluator.perform_http_request
        WebpageService.perform_http_request(webpage_request)
      end
    end
  end

  trait :lengthy_url do
    url "http://www.example.com/#{SecureRandom.hex(512)}.html"
  end
end
