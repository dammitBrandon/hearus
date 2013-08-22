class User < ActiveRecord::Base

   attr_accessible :email,:first_name,:last_name,
                   :password,:username,:password_confirmation

   has_many :accounts, :dependent => :destroy
   has_many :votes
   belongs_to :district
   belongs_to :state

   def has_facebook?
     accounts.where(provider: 'facebook').any?
   end

   def has_twitter?
     accounts.where(provider: 'twitter').any?
   end

   def has_foursquare?
     accounts.where(provider: 'foursquare').any?
   end

   def set_legislators(district_id)
    self.district_id = district.id
    self.state_id = District.find_by_id(district.id).state_id
    self.save
   end

end
