class User < ActiveRecord::Base
  devise :confirmable, :database_authenticatable, :lockable,
         :omniauthable, :recoverable, :registerable, :rememberable,
         :timeoutable, :token_authenticatable, :trackable, :validatable
end
