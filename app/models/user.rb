class User < ActiveRecord::Base
  rolify
  devise :confirmable, :database_authenticatable, :lockable,
         :omniauthable, :recoverable, :registerable, :rememberable,
         :timeoutable, :token_authenticatable, :trackable

  validates :email, presence: true, uniqueness: true, format: Devise.email_regexp
  validates :username, presence: true, uniqueness: true, format: /\A[A-Za-z0-9_]+(@([^@\s]+\.)+[^@\s]+)?\z/
  validates :password, confirmation: true, length: Devise.password_length

  # Virtual attribute for authenticating by either username or email
  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end
end
