# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  name                   :string(255)
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
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_many(:webpage_requests).dependent(:destroy) }
    it { should have_many(:authentications).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:user) }

    context 'email' do
      it { should validate_presence_of(:email) }

      it { should validate_uniqueness_of(:email).case_insensitive }

      valid_emails = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      valid_emails.each do |valid_email|
        it { should allow_value(valid_email).for(:email) }
      end

      invalid_emails = %w[user@foo,com user_at_foo.org example.user@foo.]
      invalid_emails.each do |invalid_email|
        it { should_not allow_value(invalid_email).for(:email) }
      end
    end

    context 'username' do
      it { should validate_presence_of(:username) }
      it { should validate_uniqueness_of(:username).case_insensitive }
      it { should ensure_length_of(:username).is_at_most(100) }

      valid_usernames = %w[test_user example_user username username@domain.com]
      valid_usernames.each do |valid_username|
        it { should allow_value(valid_username).for(:username) }
      end

      invalid_usernames = %W[test!user $username @domain.com .]
      invalid_usernames.each do |invalid_username|
        it { should_not allow_value(invalid_username).for(:username) }
      end
    end

    context 'password' do
      it do
        should ensure_length_of(:password)
          .is_at_least(Devise.password_length.begin)
      end

      it do
        should ensure_length_of(:password)
          .is_at_most(Devise.password_length.end)
      end

      it 'should confirm the passwords match' do
        mismatched_password = subject.password.reverse
        pw_user = build(:user, password_confirmation: mismatched_password)
        pw_user.should_not be_valid
      end

      context 'on update' do
        let(:existing_user) { create(:user) }
        it do
          existing_user.should_not validate_presence_of(:password)
            .on(:update)
        end

        it do
          existing_user.should_not validate_confirmation_of(:password)
            .on(:update)
        end
      end
    end
  end

  describe 'respond_to' do
    it { User.should respond_to(:find_first_by_auth_conditions) }
    it { User.should respond_to(:find_for_omniauth) }
  end

  describe '.find_first_by_auth_conditions' do
    let(:user) { create(:user) }

    it 'should return an ArgumentError without conditions' do
      expect do
        User.find_first_by_auth_conditions
      end.to raise_error(ArgumentError)
    end

    it 'should find the first user with empty conditions' do
      User.find_first_by_auth_conditions({}).should == User.first
    end

    it 'should find the user by email when the email key is set' do
      conditions = { email: user.email }
      User.find_first_by_auth_conditions(conditions).should == user
    end

    it 'should find the user by username when the username key is set' do
      conditions = { username: user.username }
      User.find_first_by_auth_conditions(conditions).should == user
    end

    it 'should find the user by username when the login key is set' do
      conditions = { login: user.username }
      User.find_first_by_auth_conditions(conditions).should == user
    end

    it 'should find the user by email when the login key is set' do
      conditions = { login: user.email }
      User.find_first_by_auth_conditions(conditions).should == user
    end
  end
end
