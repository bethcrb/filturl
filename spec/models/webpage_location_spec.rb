require 'rails_helper'

RSpec.describe WebpageLocation, type: :model do
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

    it 'is equal to #subdivision_code' do
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

    context 'when city=San Jose, state=CA, and country=United States' do
      it "returns 'San Jose, CA, United States'" do
        allow(location).to receive(:city).and_return('San Jose')
        allow(location).to receive(:state).and_return('CA')
        allow(location).to receive(:country).and_return('United States')
        expect(location.to_s).to eq('San Jose, CA, United States')
      end
    end

    context 'when city and state are blank and country=United States' do
      it "returns 'United States' without commas" do
        allow(location).to receive(:city) { '' }
        allow(location).to receive(:state) { '' }
        allow(location).to receive(:country) { 'United States' }
        expect(location.to_s).to eq(location.country)
      end
    end

    context 'when city, state, and country are all blank' do
      it 'returns an empty string' do
        allow(location).to receive(:city) { '' }
        allow(location).to receive(:state) { '' }
        allow(location).to receive(:country) { '' }
        expect(location.to_s).to eq('')
      end
    end

    context 'when primary ip can not be located' do
      it 'returns an empty string' do
        allow(webpage).to receive(:primary_ip) { '0.0.0.0' }

        expect(location.to_s).to eq('')
      end
    end
  end

  describe '#respond_to?' do
    it 'does not respond to missing methods' do
      expect(location).not_to respond_to(:not_a_method)
    end
  end

  describe '#method_missing' do
    it 'raises an error when the method does not exist' do
      expect { location.not_a_method }.to raise_error(NameError)
    end
  end
end
