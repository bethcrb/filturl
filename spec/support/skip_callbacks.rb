shared_context 'skip screenshot callbacks' do
  before do
    Screenshot.skip_callback(:save, :after, :upload_screenshot)
  end

  after do
    Screenshot.set_callback(:save, :after, :upload_screenshot)
  end
end
