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

class HttpStatusCode < ActiveRecord::Base
  validates :value, presence: true
  validates :value, uniqueness: true
  validates :value, numericality: { only_integer: true }

  validates :description, presence: true
  validates :reference, presence: true

  alias_attribute :code, :value
end
