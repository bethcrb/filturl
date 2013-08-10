# == Schema Information
#
# Table name: webpages
#
#  id            :integer          not null, primary key
#  effective_url :string(255)      default(""), not null
#  primary_ip    :string(255)
#  body          :text(2147483647)
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Webpage do
  describe 'associations' do
    it { should have_one(:screenshot).dependent(:destroy) }

    it { should have_many(:webpage_responses).dependent(:destroy) }
    it { should have_many(:webpage_requests).through(:webpage_responses) }
  end

  describe 'validations' do
    it { should validate_presence_of(:effective_url) }
    it { should validate_uniqueness_of(:effective_url) }
    it { should_not allow_value('www.example.com').for(:effective_url) }
    it { should allow_value('http://www.example.com/').for(:effective_url) }
  end

  describe ':after_create' do
    it 'should create a screenshot object' do
      webpage = create(:webpage)
      webpage.screenshot.should_not be_nil
    end
  end
end
