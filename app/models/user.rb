class User < ActiveRecord::Base
   has_secure_password
   has_many :accounts, :dependent => :destroy
   has_many :votes

   belongs_to :district
   attr_accessible :email,
     :first_name,
     :last_name,
     :password,
     :username,
     :password_confirmation

   # after_update :set_representative, :if => :district_id_changed?

   # commented for use with new oauth method, appears in RegularUser model
   # validates_presence_of :email,
   #                      :password
   # validates :email,  uniqueness: true,
   #                   format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "%{value} is not a valid email address." }
   # end comment section, though twitter method below should do something
   #
   #
   def send_tweet

   end

   def has_facebook?
     accounts.where(provider: 'facebook').any?
   end

   def has_twitter?
     accounts.where(provider: 'twitter').any?
   end

   def has_foursquare?
     accounts.where(provider: 'foursquare').any?
   end

   def set_representative(district_id)
     self.district = District.find(district_id)
     self.state_abbreviation = self.district.state_abbreviation
     self.state_full_name = self.district.state_full_name
     self.rep_name = self.district.rep_name
     self.rep_email_form = self.district.rep_email_form
     self.rep_party = self.district.rep_party
     self.rep_phone = self.district.rep_phone
     self.rep_twitter = self.district.rep_twitter
     self.rep_facebook = self.district.rep_facebook
     self.rep_youtube = self.district.rep_youtube
     self.rep_wiki = self.district.rep_wiki
     self.rep_bioguide_id = self.district.bioguide_id
     self.save
   end

end

