# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  username               :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0)
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  failed_attempts        :integer          default(0)
#  unlock_token           :string(255)
#  locked_at              :datetime
#  created_at             :datetime
#  updated_at             :datetime
#  role                   :integer          default(0)
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_role                  (role)
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#  login                                (email,username)
#

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:authentications).dependent(:destroy) }
    it { is_expected.to have_many(:webpage_requests).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:user) }

    context 'email' do
      it { is_expected.to validate_presence_of(:email) }

      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

      valid_emails = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      valid_emails.each do |valid_email|
        it { is_expected.to allow_value(valid_email).for(:email) }
      end

      invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      invalid_emails.each do |invalid_email|
        it { is_expected.not_to allow_value(invalid_email).for(:email) }
      end
    end

    context 'username' do
      it { is_expected.to validate_presence_of(:username) }
      it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
      it { is_expected.to validate_length_of(:username).is_at_most(100) }

      valid_usernames = %w[test_user example_user username username@domain.com]
      valid_usernames.each do |valid_username|
        it { is_expected.to allow_value(valid_username).for(:username) }
      end

      invalid_usernames = %W[test!user $username @domain.com .]
      invalid_usernames.each do |invalid_username|
        it { is_expected.not_to allow_value(invalid_username).for(:username) }
      end
    end

    context 'password' do
      it do
        is_expected.to validate_length_of(:password)
          .is_at_least(Devise.password_length.begin)
      end

      it do
        is_expected.to validate_length_of(:password)
          .is_at_most(Devise.password_length.end)
      end

      it 'confirms the passwords match' do
        mismatched_password = subject.password.reverse
        pw_user = build(:user, password_confirmation: mismatched_password)
        expect(pw_user).not_to be_valid
      end

      context 'on update' do
        let(:existing_user) { create(:user) }
        it do
          expect(existing_user).not_to validate_presence_of(:password)
        end
      end
    end
  end

  describe 'respond_to' do
    it { expect(User).to respond_to(:find_first_by_auth_conditions) }
  end

  describe '.find_first_by_auth_conditions' do
    let(:user) { create(:user) }

    it 'returns an ArgumentError without conditions' do
      expect do
        User.find_first_by_auth_conditions
      end.to raise_error(ArgumentError)
    end

    it 'finds the first user with empty conditions' do
      expect(User.find_first_by_auth_conditions({})).to eq(User.first)
    end

    it 'finds the user by email when the email key is set' do
      conditions = { email: user.email }
      expect(User.find_first_by_auth_conditions(conditions)).to eq(user)
    end

    it 'finds the user by username when the username key is set' do
      conditions = { username: user.username }
      expect(User.find_first_by_auth_conditions(conditions)).to eq(user)
    end

    it 'finds the user by username when the login key is set' do
      conditions = { login: user.username }
      expect(User.find_first_by_auth_conditions(conditions)).to eq(user)
    end

    it 'finds the user by email when the login key is set' do
      conditions = { login: user.email }
      expect(User.find_first_by_auth_conditions(conditions)).to eq(user)
    end
  end
end
