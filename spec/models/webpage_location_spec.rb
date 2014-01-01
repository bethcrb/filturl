require 'spec_helper'

describe WebpageLocation do
  let(:webpage) { build :webpage }
  let(:location) { webpage.location }

  describe '#city' do
    it "returns a string" do
      location.city.should be_a(String)
    end
  end

  describe '#state' do
    it "returns a string" do
      location.state.should be_a(String)
    end
  end

  describe '#country' do
    it "returns a string" do
      location.country.should be_a(String)
    end
  end

  describe '#to_s' do
    describe 'when city, state, and country are all present' do
      it "returns a comma separated string with the city, state, and country" do
        location.to_s.should be == "#{location.city}, #{location.state}, #{location.country}"
      end
    end

    describe 'when country is present and city and state are blank' do
      it 'returns a string with the country name and no commas' do
        location.stub(:city).and_return('')
        location.stub(:state).and_return('')

        location.to_s.should be == location.country
      end
    end

    describe 'when city, state, and country are all blank' do
      it 'returns an empty string' do
        location.stub(:city).and_return('')
        location.stub(:state).and_return('')
        location.stub(:country).and_return('')

        location.to_s.should be == ''
      end
    end

    describe 'when primary ip can not be located' do
      it 'returns an empty string' do
        webpage.stub(:primary_ip).and_return('0.0.0.0')

        location.to_s.should be == ''
      end
    end
  end
end
