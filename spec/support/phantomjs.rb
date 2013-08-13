shared_context 'phantomjs' do
  let!(:screenshot) { create(:screenshot) }

  before(:each) do
    screenshot.send(:set_filename)
    Phantomjs.stub(:run) do
      FileUtils.touch("tmp/screenshots/#{screenshot.filename}")
    end
  end
end
