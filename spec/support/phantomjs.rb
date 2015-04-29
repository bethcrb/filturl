RSpec.shared_context 'phantomjs' do
  before(:each) do
    allow(Phantomjs).to receive(:run) do |*args, screenshot_js, screenshot_url, temp_file|
      FileUtils.touch(temp_file)
    end
  end
end
