require 'spec_helper'

describe Webpage do
  include_context 'skip screenshot callbacks'

  describe 'associations' do
    it { should have_one(:screenshot).dependent(:destroy) }

    it { should have_many(:webpage_responses).dependent(:destroy) }
    it { should have_many(:webpage_requests).through(:webpage_responses) }
    it { should have_many(:user_url_histories).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:url) }
    it { should validate_uniqueness_of(:url) }
    it { should_not allow_value('www.example.com').for(:url) }
    it { should allow_value('http://www.example.com/').for(:url) }
  end

  describe ':after_create' do
    it 'should create a screenshot object' do
      webpage = create(:webpage)
      webpage.screenshot.should_not be_nil
    end
  end
end
