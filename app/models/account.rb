class Account < ActiveRecord::Base
  belongs_to :user
  attr_accessible :user_id, :provider, :oauth_expires, :oauth_secret, :oauth_token, :uid, :username
end
