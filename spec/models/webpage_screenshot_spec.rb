# == Schema Information
#
# Table name: webpage_screenshots
#
#  id                  :integer          not null, primary key
#  filename            :string(255)
#  url                 :string(255)
#  webpage_response_id :integer
#  created_at          :datetime
#  updated_at          :datetime
#

require 'spec_helper'

describe WebpageScreenshot do
  before do
    WebpageScreenshot.skip_callback(:create, :after, :generate_screenshot)
    WebpageScreenshot.skip_callback(:create, :after, :upload_screenshot)
    WebpageScreenshot.skip_callback(:destroy, :before, :delete_screenshot)
  end
  after do
    WebpageScreenshot.set_callback(:create, :after, :generate_screenshot)
    WebpageScreenshot.set_callback(:create, :after, :upload_screenshot)
    WebpageScreenshot.set_callback(:destroy, :before, :delete_screenshot)
  end

  describe 'associations' do
    it { should belong_to(:webpage_response) }
    it { should have_one(:webpage_request).through(:webpage_response) }
  end

  describe 'validations' do
    it { should validate_presence_of(:webpage_response) }
  end

  describe 'respond_to' do
    it { should respond_to(:filename) }
  end

  describe 'creating screenshots', :vcr do
    let!(:webpage_screenshot) { create(:webpage_screenshot) }

    describe 'generate_screenshot' do
      it { webpage_screenshot.generate_screenshot.should be_true }
    end

    describe 'upload_screenshot' do
      it { webpage_screenshot.upload_screenshot.should be_true }
    end

    describe 'delete_screenshot' do
      it { webpage_screenshot.delete_screenshot.should be_nil }
    end

    describe 'set_filename' do
      it 'should set the filename if one does not exist', :vcr do
        screenshot_no_filename = create(:webpage_screenshot, filename: nil)
        screenshot_no_filename.set_filename
        screenshot_no_filename.filename.should_not be_nil
      end

      it 'should not change the filename if one already exists', :vcr do
        filename = "#{SecureRandom.urlsafe_base64}.png"
        screenshot_with_filename = build_stubbed(
          :webpage_screenshot,
          filename: filename
        )
        screenshot_with_filename.set_filename
        screenshot_with_filename.filename.should == filename
      end
    end
  end
end
