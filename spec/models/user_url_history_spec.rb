require 'spec_helper'

describe UserUrlHistory do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:webpage) }
  end

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url).scoped_to(:user_id).case_insensitive }
    it { should_not allow_value('www.example.com').for(:url) }
    it { should allow_value('http://www.example.com/').for(:url) }

    it { should validate_presence_of(:last_requested_at) }

    it { should validate_presence_of(:user) }

    it { should validate_presence_of(:webpage) }
  end
end
