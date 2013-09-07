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

class User < ActiveRecord::Base
  rolify
  devise :confirmable, :database_authenticatable, :lockable,
         :omniauthable, :recoverable, :registerable, :rememberable,
         :token_authenticatable, :trackable

  has_many :user_url_histories, dependent: :destroy
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

  def self.find_for_omniauth(auth, signed_in_resource = nil)
    username = auth.info.nickname
    username = auth.info.email if username.blank?

    user = User.find_by(email: auth.info.email)
    unless user
      user_by_username = User.find_by(username: username)
      username = auth.info.email unless user_by_username.nil?

      user = User.new(
        name:     auth.info.name,
        email:    auth.info.email,
        username: username,
        password: Devise.friendly_token[0, 20],
      )
      user.skip_confirmation!
      user.save!
    end

    authentication = user.authentications.find_or_create_by(
      provider: auth.provider,
      uid:      auth.uid,
    )

    authentication.name = auth.info.name
    authentication.email = auth.info.email
    authentication.nickname = auth.info.nickname if auth.info.nickname
    authentication.first_name = auth.info.first_name
    authentication.last_name = auth.info.last_name
    authentication.image = auth.info.image
    authentication.raw_info = auth.to_json
    authentication.save!

    user
  end
end
