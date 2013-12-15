# == Schema Information
#
# Table name: http_status_codes
#
#  id          :integer          not null, primary key
#  value       :integer
#  description :string(255)
#  reference   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :http_status_code do
    value 500
    description 'Internal Server Error'
    reference '[RFC2616]'
  end
end
