require 'spec_helper'

describe WebpageEncoder do
  include_context 'skip screenshot callbacks'

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
