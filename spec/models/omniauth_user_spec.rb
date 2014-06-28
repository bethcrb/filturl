require 'rails_helper'
require File.expand_path('../../../features/support/omniauth',  __FILE__)

auth = OmniAuth.config.mock_auth[:facebook]

RSpec.describe OmniauthUser, type: :model do
  describe '#find_or_create_user' do
    context 'when a user with the same e-mail address already exists' do
      it 'uses the existing user' do
        existing_user = create(:user, email: auth.info.email)
        omniauth_user = OmniauthUser.new(auth).find_or_create_user
        expect(omniauth_user).to eq(existing_user)
      end
    end

    context 'when a user with the e-mail address does not already exist' do
      it 'creates a new user' do
        expect(OmniauthUser.new(auth).find_or_create_user).to be_a(User)
      end
    end

    context 'when the username is not in use' do
      it 'uses the nickname as the username' do
        omniauth_user = OmniauthUser.new(auth).find_or_create_user
        expect(omniauth_user.username).to eq(auth.info.nickname)
      end
    end

    context 'when there is no nickname' do
      it 'uses the e-mail address as the username' do
        no_nickname = auth.dup
        no_nickname.info.nickname = nil
        omniauth_user = OmniauthUser.new(no_nickname).find_or_create_user
        expect(omniauth_user.username).to eq(no_nickname.info.email)
      end
    end

    context 'when the username is already in use' do
      it 'uses the e-mail address as the username' do
        email = Faker::Internet.email
        create(:user, email: email, username: auth.info.nickname)
        omniauth_user = OmniauthUser.new(auth).find_or_create_user
        expect(omniauth_user.username).to eq(auth.info.email)
      end
    end

    context 'after it finds or creates the user' do
      it 'saves the omniauth details' do
        omniauth_user = OmniauthUser.new(auth).find_or_create_user
        omniauth_details = Authentication.find_by(email: auth.info.email)
        omniauth_user.authentications.include?(omniauth_details)
      end
    end
  end
end
