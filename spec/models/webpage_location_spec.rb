require 'spec_helper'

describe WebpageLocation do
  let(:webpage) { build :webpage, primary_ip: '54.215.159.82' }
  let(:location) { WebpageLocation.new(webpage) }

  describe '#city' do
    it { expect(location).to respond_to(:city) }

    it "returns 'San Jose' for 54.215.159.82" do
      expect(location.city).to eq('San Jose')
    end
  end

  describe '#state' do
    it { expect(location).to respond_to(:state) }

    it 'should be equal to #subdivision_code' do
      expect(location.state).to eq(location.subdivision_code)
    end

    it "returns 'CA' for 54.215.159.82" do
      expect(location.state).to eq('CA')
    end
  end

  describe '#country' do
    it { expect(location).to respond_to(:country) }

    it "returns 'United States' for 54.215.159.82" do
      expect(location.country).to eq('United States')
    end
  end

  describe '#to_s' do
    it { expect(location).to respond_to(:to_s) }

    describe 'when city=San Jose, state=CA, and country=United States' do
      it "returns 'San Jose, CA, United States'" do
        location.stub(:city).and_return('San Jose')
        location.stub(:state).and_return('CA')
        location.stub(:country).and_return('United States')
        expect(location.to_s).to eq('San Jose, CA, United States')
      end
    end

    describe 'when city and state are blank and country=United States' do
      it "returns 'United States' without commas" do
        location.stub(:city).and_return('')
        location.stub(:state).and_return('')
        location.stub(:country).and_return('United States')
        expect(location.to_s).to eq(location.country)
      end
    end

    describe 'when city, state, and country are all blank' do
      it 'returns an empty string' do
        location.stub(:city).and_return('')
        location.stub(:state).and_return('')
        location.stub(:country).and_return('')
        expect(location.to_s).to eq('')
      end
    end

    describe 'when primary ip can not be located' do
      it 'returns an empty string' do
        webpage.stub(:primary_ip).and_return('0.0.0.0')

        expect(location.to_s).to eq('')
      end
    end
  end

  describe '#respond_to?' do
    it 'should not respond to missing methods' do
      expect(location).to_not respond_to(:not_a_method)
    end
  end

  describe '#method_missing' do
    it 'raises an error when the method does not exist' do
      expect { location.not_a_method }.to raise_error(NameError)
    end
  end
end
