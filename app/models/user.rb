class User < ActiveRecord::Base
  has_many :accounts, :dependent => :destroy
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
  # has_secure_password
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

  # def get_zipcode(zipcode)
  #   if zipcode.class == String
  #     set_district_by_zipcode(zipcode.strip.to_i)
  #   else
  #     set_district_by_zipcode(zipcode)
  #   end
  # end

  # def get_coordinates(address)
  #   coordinates = Geocoder.coordinates(address)
  #   self.latitude = coordinates[0]
  #   self.longitude = coordinates[1]
  #   self.save
  #   set_district
  # end

  # protected

  # def set_district_by_zipcode(zipcode)
  #   legislators = Sunlight::Legislator.all_in_zipcode(zipcode)
  #   if legislators.length <= 3
  #     legislators.each do |leg|
  #       if leg.title == "Rep"
  #         self.district = District.where("state_name = ? AND number = ?", leg.state, leg.district.to_i )[0]
  #         self.save
  #         set_representative
  #       end
  #     end
  #   true
  #  else
  #   false
  #  end
  # end

  # def set_district_by_coordinates
  #   district = Sunlight::District.get(:latitude => self.latitude,
  #                                     :longitude => self.longitude)
  #   self.district = District.find_by_number(district.number.to_i)
  #   self.state = district.state
  #   self.district_number = district.number.to_i
  #   self.save
  #   set_representative
  # end

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
    self.save
  end

end

