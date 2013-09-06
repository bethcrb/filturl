class UserUrlHistory < ActiveRecord::Base
  belongs_to :webpage
  belongs_to :user
end
