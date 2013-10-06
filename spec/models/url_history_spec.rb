# == Schema Information
#
# Table name: url_histories
#
#  id         :integer          not null, primary key
#  url        :string(500)
#  webpage_id :integer
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe UrlHistory do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:webpage) }
  end

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should_not allow_value('www.example.com').for(:url) }
    it { should allow_value('http://www.example.com/').for(:url) }

    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:webpage) }
  end
end