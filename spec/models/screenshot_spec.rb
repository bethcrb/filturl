# == Schema Information
#
# Table name: screenshots
#
#  id         :integer          not null, primary key
#  filename   :string(255)
#  url        :string(2000)
#  status     :string(255)      default("new")
#  webpage_id :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_screenshots_on_webpage_id  (webpage_id)
#

require 'rails_helper'

RSpec.describe Screenshot, type: :model do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  let!(:screenshot) { create(:screenshot) }

  describe 'associations' do
    it { is_expected.to belong_to(:webpage) }
    it { is_expected.to have_many(:webpage_responses).through(:webpage) }
    it { is_expected.to have_many(:webpage_requests).through(:webpage_responses) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:webpage) }
    it { is_expected.to ensure_length_of(:url).is_at_most(2000) }
    it { is_expected.to validate_inclusion_of(:status).in_array(%w(active inactive new)) }
  end

  describe 'respond_to' do
    it { is_expected.to respond_to(:filename) }
  end

  describe 'creating screenshots' do
    describe 'generate_screenshot' do
      it { expect(screenshot.generate_screenshot).to be true }
    end

    describe 'upload_screenshot' do
      it { expect(screenshot.upload_screenshot).to be true }
      it 'sets the status to active when it is successful' do
        screenshot.upload_screenshot
        expect(screenshot.status).to eq('active')
      end
    end

    describe 'delete_screenshot' do
      it { expect(screenshot.delete_screenshot).to be_nil }
    end

    describe 'set_filename' do
      it 'sets the filename if one does not exist' do
        screenshot.update_attributes!(filename: nil)
        screenshot.send(:set_filename)
        expect(screenshot.filename).not_to be_nil
      end

      it 'does not change the filename if one already exists' do
        random_filename = "#{SecureRandom.urlsafe_base64}.png"
        screenshot.update_attributes!(filename: random_filename)
        screenshot.send(:set_filename)
        expect(screenshot.filename).to eq(random_filename)
      end
    end

    describe 'needs_update?' do
      it 'returns true if the url is blank' do
        screenshot.update_attributes!(url: nil)
        expect(screenshot.needs_update?).to be true
      end
    end
  end
end
