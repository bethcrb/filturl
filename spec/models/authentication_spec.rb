# == Schema Information
#
# Table name: authentications
#
#  id         :integer          not null, primary key
#  provider   :string(255)
#  uid        :string(255)
#  name       :string(255)
#  email      :string(255)
#  nickname   :string(255)
#  first_name :string(255)
#  last_name  :string(255)
#  image      :string(255)
#  raw_info   :text
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Authentication do
  it { should belong_to(:user) }
end
