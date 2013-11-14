# == Schema Information
#
# Table name: url_histories
#
#  id         :integer          not null, primary key
#  url        :string(2000)
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
    it { should ensure_length_of(:url).is_at_most(2000) }

    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:webpage) }
  end
end
