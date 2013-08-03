# == Schema Information
#
# Table name: screenshots
#
#  id         :integer          not null, primary key
#  filename   :string(255)
#  url        :string(255)
#  webpage_id :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Screenshot do
  describe 'associations' do
    it { should belong_to(:webpage) }
    it { should have_many(:webpage_responses).through(:webpage) }
    it { should have_many(:webpage_requests).through(:webpage_responses) }
  end

  describe 'validations' do
    it { should validate_presence_of(:webpage) }
  end

  describe 'respond_to' do
    it { should respond_to(:filename) }
  end

  describe 'creating screenshots' do
    let!(:screenshot) { create(:screenshot) }

    describe 'generate_screenshot' do
      it { screenshot.generate_screenshot.should be_true }
    end

    describe 'upload_screenshot' do
      it { screenshot.upload_screenshot.should be_true }
    end

    describe 'delete_screenshot' do
      it { screenshot.delete_screenshot.should be_nil }
    end

    describe 'set_filename' do
      it 'should set the filename if one does not exist' do
        screenshot.update_attributes!(filename: nil)
        screenshot.set_filename
        screenshot.filename.should_not be_nil
      end

      it 'should not change the filename if one already exists' do
        random_filename = "#{SecureRandom.urlsafe_base64}.png"
        screenshot.update_attributes!(filename: random_filename)
        screenshot.set_filename
        screenshot.filename.should == random_filename
      end
    end
  end
end
