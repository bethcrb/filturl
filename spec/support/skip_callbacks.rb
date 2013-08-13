shared_context 'skip screenshot callbacks' do
  before do
    Screenshot.skip_callback(:update, :after, :upload_screenshot)
  end

  after do
    Screenshot.set_callback(:update, :after, :upload_screenshot)
  end
end
