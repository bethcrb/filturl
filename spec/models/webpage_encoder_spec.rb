require 'rails_helper'

RSpec.describe WebpageEncoder, type: :model do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  before(:each) do
    VCR.use_cassette('WebpageRequest/create') do
      @webpage_request = create(
        :webpage_request,
        perform_http_request: true
      )
      @webpage = @webpage_request.webpage
    end
  end

  describe '#content_type' do
    it 'returns webpage.content_type' do
      expect(WebpageEncoder.new(@webpage).content_type)
        .to eq(@webpage.content_type)
    end
  end

  describe '#mime_type' do
    it 'returns nil unless a content type is present' do
      @webpage.update_attributes!(content_type: nil)
      expect(WebpageEncoder.new(@webpage).mime_type).to be_nil
    end

    it 'returns nil unless the content type is in MIME::Types' do
      @webpage.update_attributes!(content_type: 'invalid/type')
      expect(WebpageEncoder.new(@webpage).mime_type).to be_nil
    end

    it 'returns the first mime type based on content_type' do
      @webpage.update_attributes!(content_type: 'text/html')
      expect(WebpageEncoder.new(@webpage).mime_type)
        .to eq(MIME::Types[@webpage.content_type].first)
    end
  end

  describe '#mime_type_allowed?' do
    it 'returns false if the webpage does not have a content type set' do
      @webpage.update_attributes!(content_type: nil)
      expect(WebpageEncoder.new(@webpage).mime_type_allowed?).to be false
    end

    it 'returns false if the MIME type is not allowed' do
      @webpage.update_attributes!(content_type: 'application/pdf')
      expect(WebpageEncoder.new(@webpage).mime_type_allowed?).to be false
    end

    it 'returns true if the MIME type is allowed' do
      @webpage.update_attributes!(content_type: 'text/html')
      expect(WebpageEncoder.new(@webpage).mime_type_allowed?).to be true
    end
  end

  describe '#encoded_body' do
    before do
      Webpage.skip_callback(:save, :before, :encode_body)
    end

    after do
      Webpage.set_callback(:save, :before, :encode_body)
    end

    it 'returns nil if the content type is not present' do
      @webpage.update_attributes!(content_type: nil)
      expect(WebpageEncoder.new(@webpage).encoded_body).to be_nil
    end

    it 'returns nil if the content type is not allowed' do
      @webpage.update_attributes!(content_type: 'invalid/type')
      expect(WebpageEncoder.new(@webpage).encoded_body).to be_nil
    end

    it 'sets the meta encoding' do
      @webpage.update_attributes!(meta_encoding: nil)
      WebpageEncoder.new(@webpage).encoded_body
      expect(@webpage.meta_encoding).not_to be_nil
    end

    it 'returns it as is if it is already UTF-8' do
      allow(@webpage.body).to receive(:is_utf8?) { true }
      expect(WebpageEncoder.new(@webpage).encoded_body).to eq(@webpage.body)
    end
  end

  describe 'encoding' do
    it 'is UTF-8 for Big5' do
      webpage = build_stubbed(:webpage, :big5)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for EUC-JP' do
      webpage = build_stubbed(:webpage, :eucjp)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for EUC-KR' do
      webpage = build_stubbed(:webpage, :euckr)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for GB2312' do
      webpage = build_stubbed(:webpage, :gb2312)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for GBK' do
      webpage = build_stubbed(:webpage, :gbk)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for ISO-8859-1' do
      webpage = build_stubbed(:webpage, :iso885901)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for ISO-8859-2' do
      webpage = build_stubbed(:webpage, :iso885902)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for ISO-8859-9' do
      webpage = build_stubbed(:webpage, :iso885909)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for ISO-8859-15' do
      webpage = build_stubbed(:webpage, :iso885915)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for Shift JIS' do
      webpage = build_stubbed(:webpage, :shiftjis)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for Windows-874' do
      webpage = build_stubbed(:webpage, :windows874)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for Windows-1250' do
      webpage = build_stubbed(:webpage, :windows1250)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for Windows-1251' do
      webpage = build_stubbed(:webpage, :windows1251)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for Windows-1252' do
      webpage = build_stubbed(:webpage, :windows1252)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for Windows-1254' do
      webpage = build_stubbed(:webpage, :windows1254)
      expect(webpage.body.is_utf8?).to be true
    end

    it 'is UTF-8 for Windows-1256' do
      webpage = build_stubbed(:webpage, :windows1256)
      expect(webpage.body.is_utf8?).to be true
    end
  end
end
