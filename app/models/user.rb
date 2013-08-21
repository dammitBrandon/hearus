class User < ActiveRecord::Base
   has_secure_password

   attr_accessible :email,:first_name,:last_name,
                   :password,:username,:password_confirmation

   has_many :accounts, :dependent => :destroy
   has_many :votes
   belongs_to :district

   def has_facebook?
     accounts.where(provider: 'facebook').any?
   end

   def has_twitter?
     accounts.where(provider: 'twitter').any?
   end

   def has_foursquare?
     accounts.where(provider: 'foursquare').any?
   end
end
