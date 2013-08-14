shared_context 'skip screenshot callbacks' do
  before do
    Screenshot.skip_callback(:create, :after, :upload_screenshot)
  end

  after do
    Screenshot.set_callback(:create, :after, :upload_screenshot)
  end
end
