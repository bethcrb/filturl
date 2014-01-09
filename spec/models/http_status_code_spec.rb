# == Schema Information
#
# Table name: http_status_codes
#
#  id          :integer          not null, primary key
#  value       :integer
#  description :string(255)
#  reference   :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

require 'spec_helper'

describe HttpStatusCode do
  subject { create(:http_status_code) }

  describe 'validations' do
    context 'with valid attributes' do
      it { should be_valid }
    end

    it { should validate_presence_of(:value) }
    it { should validate_uniqueness_of(:value).case_insensitive }
    it { should validate_numericality_of(:value).only_integer }

    it { should validate_presence_of(:description) }

    it { should validate_presence_of(:reference) }
  end

  describe '.code' do
    it { expect(subject.code).to eq(subject.value) }
  end
end
