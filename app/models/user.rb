class User < ActiveRecord::Base
  rolify
  devise :confirmable, :database_authenticatable, :lockable,
         :omniauthable, :recoverable, :registerable, :rememberable,
         :timeoutable, :token_authenticatable, :trackable, :validatable
end
