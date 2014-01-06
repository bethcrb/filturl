require 'spec_helper'

describe WebpageEncoder do
  include_context 'skip screenshot callbacks'
  include_context 'phantomjs'

  before(:each) do
    VCR.use_cassette('WebpageRequest/create') do
      @webpage_request = create(:webpage_request)
      @webpage = @webpage_request.webpage
    end
  end

  describe '#content_type' do
    it 'returns webpage.content_type' do
      WebpageEncoder.new(@webpage).content_type.should == @webpage.content_type
    end
  end

  describe '#mime_type' do
    it 'returns nil unless a content type is present', :vcr do
      @webpage.update_attributes!(content_type: nil)
      WebpageEncoder.new(@webpage).mime_type.should be_nil
    end

    it 'returns nil unless the content type is in MIME::Types', :vcr do
      @webpage.update_attributes!(content_type: 'invalid/type')
      WebpageEncoder.new(@webpage).mime_type.should be_nil
    end

    it 'returns the first mime type based on content_type', :vcr do
      @webpage.update_attributes!(content_type: 'text/html')
      WebpageEncoder.new(@webpage).mime_type.should ==
        MIME::Types[@webpage.content_type].first
    end
  end

  describe '#mime_type_allowed?' do
    it 'returns false if the webpage does not have a content type set' do
      @webpage.update_attributes!(content_type: nil)
      WebpageEncoder.new(@webpage).mime_type_allowed?.should be_false
    end

    it 'returns false if the MIME type is not allowed' do
      @webpage.update_attributes!(content_type: 'application/pdf')
      WebpageEncoder.new(@webpage).mime_type_allowed?.should be_false
    end

    it 'returns true if the MIME type is allowed' do
      @webpage.update_attributes!(content_type: 'text/html')
      WebpageEncoder.new(@webpage).mime_type_allowed?.should be_true
    end
  end

  describe '#encoded_body' do
    before do
      Webpage.skip_callback(:save, :before, :encode_body)
    end

    after do
      Webpage.set_callback(:save, :before, :encode_body)
    end

    it 'returns nil if the content type is not present', :vcr do
      @webpage.update_attributes!(content_type: nil)
      WebpageEncoder.new(@webpage).encoded_body.should be_nil
    end

    it 'returns nil if the content type is not allowed', :vcr do
      @webpage.update_attributes!(content_type: 'invalid/type')
      WebpageEncoder.new(@webpage).encoded_body.should be_nil
    end

    it 'should set the meta encoding', :vcr do
      @webpage.update_attributes!(meta_encoding: nil)
      WebpageEncoder.new(@webpage).encoded_body
      @webpage.meta_encoding.should_not be_nil
    end

    it 'returns it as is if it is already UTF-8', :vcr do
      @webpage.body.stub(:is_utf8?).and_return(true)
      WebpageEncoder.new(@webpage).encoded_body.should == @webpage.body
    end
  end

  describe 'encoding' do
    it 'should be UTF-8 for Big5', :vcr do
      webpage_request = create(:webpage_request, :big5)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for EUC-JP', :vcr do
      webpage_request = create(:webpage_request, :eucjp)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for EUC-KR', :vcr do
      webpage_request = create(:webpage_request, :euckr)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for GB2312', :vcr do
      webpage_request = create(:webpage_request, :gb2312)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for GBK', :vcr do
      webpage_request = create(:webpage_request, :gbk)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for ISO-8859-1', :vcr do
      webpage_request = create(:webpage_request, :iso885901)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for ISO-8859-2', :vcr do
      webpage_request = create(:webpage_request, :iso885902)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for ISO-8859-9', :vcr do
      webpage_request = create(:webpage_request, :iso885909)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for ISO-8859-15', :vcr do
      webpage_request = create(:webpage_request, :iso885915)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for Shift JIS', :vcr do
      webpage_request = create(:webpage_request, :shiftjis)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for Windows-874', :vcr do
      webpage_request = create(:webpage_request, :windows874)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for Windows-1250', :vcr do
      webpage_request = create(:webpage_request, :windows1250)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for Windows-1251', :vcr do
      webpage_request = create(:webpage_request, :windows1251)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for Windows-1252', :vcr do
      webpage_request = create(:webpage_request, :windows1252)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for Windows-1254', :vcr do
      webpage_request = create(:webpage_request, :windows1254)
      webpage_request.webpage.body.is_utf8?.should be_true
    end

    it 'should be UTF-8 for Windows-1256', :vcr do
      webpage_request = create(:webpage_request, :windows1256)
      webpage_request.webpage.body.is_utf8?.should be_true
    end
  end
end
