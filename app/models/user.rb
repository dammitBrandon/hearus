class User < ActiveRecord::Base
  attr_accessible :district_id, :email, :first_name, :last_name, :password, :password_confirmation, :user_name

#  validates_presence_of :email, :password, :password_confirmation
#  validates :email, format: {with: /.+@.+\..+/}, uniqueness: true

  has_secure_password
end
