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
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_unlock_token          (unlock_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#  login                                (email,username)
#

class User < ActiveRecord::Base
  enum role: { guest: 0, admin: 1, user: 2 }

  after_initialize :set_default_role, if: :new_record?

  devise :confirmable, :database_authenticatable, :lockable,
         :omniauthable, :recoverable, :registerable, :rememberable,
         :trackable

  has_many :webpage_requests, dependent: :destroy, inverse_of: :user
  has_many :authentications, dependent: :destroy

  validates :email, presence: true, uniqueness: { case_sensitive: false },
    format: Devise.email_regexp
  validates :username, presence: true, uniqueness: { case_sensitive: false },
    format: /\A\w[-\w.]*?(@([^@\s]+\.)+[^@\s]+)?\Z/, length: { within: 1..100 }

  validates :password, presence: true, confirmation: true,
    length: Devise.password_length, on: :create
  validates :password, length: Devise.password_length, confirmation: true,
    allow_blank: true, on: :update

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login

  # This ovverides a Devise method in order to allow users to sign in using
  # either their username or e-mail address.
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login.present?
      where(conditions).where([
        'lower(username) = :value OR lower(email) = :value',
        { value: login.downcase }
      ]).first
    else
      where(conditions).first
    end
  end

  private

  def set_default_role
    self.role ||= :guest
  end
end
