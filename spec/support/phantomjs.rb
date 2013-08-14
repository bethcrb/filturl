shared_context 'phantomjs' do
  before(:each) do
    Phantomjs.stub(:run) do |options, screenshot_js, screenshot_url, temp_file|
      FileUtils.touch(temp_file)
    end
  end
end
