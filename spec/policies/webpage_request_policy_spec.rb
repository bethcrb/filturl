require 'rails_helper'

describe WebpageRequestPolicy do
  subject { WebpageRequestPolicy.new(user, webpage_request) }

  let(:webpage_request) { create(:webpage_request) }

  before(:example) { create_list(:webpage_request, 5) }

  context 'for user' do
    let(:user) { webpage_request.user }

    it { is_expected.to authorize(:show) }
    it { is_expected.to authorize(:new) }
    it { is_expected.to authorize(:create) }

    describe '.scope' do
      let(:scope) { Pundit.policy_scope(user, WebpageRequest).all }
      it 'returns WebpageRequest records that the user created' do
        expect(scope).to match_array WebpageRequest.where(user_id: user.id)
      end
    end
  end

  context 'for admin' do
    let(:user) { create(:admin) }

    it { is_expected.to authorize(:show)  }
    it { is_expected.to authorize(:new) }
    it { is_expected.to authorize(:create) }

    describe '.scope' do
      let(:scope) { Pundit.policy_scope(user, WebpageRequest).all }
      it 'returns all WebpageRequest records' do
        expect(scope).to match_array(WebpageRequest.all)
      end
    end
  end
end
