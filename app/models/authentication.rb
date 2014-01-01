# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  email      :string(255)
#  nickname   :string(255)
#  image      :string(255)
#  raw_info   :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_authentications_on_user_id  (user_id)
#

class Authentication < ActiveRecord::Base
  belongs_to :user
end
