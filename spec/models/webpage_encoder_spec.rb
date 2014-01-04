require 'spec_helper'

describe WebpageEncoder do
  include_context 'skip screenshot callbacks'

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
