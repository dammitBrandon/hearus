class User < ActiveRecord::Base
  attr_accessible :email,
                  :first_name,
                  :last_name,
                  :password,
                  :username
  after_update :set_representative, :if => :district_id_changed?

  validates_presence_of :email,
                        :password

  validates :email,  uniqueness: true,
                     format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "%{value} is not a valid email address." }

  has_secure_password

  def send_tweet

  end

  protected

  def set_representative
    district = District.find(self.district_id)
    user.rep_name = district.rep_name
    user.rep_email = district.rep_email
    user.rep_twitter = district.rep_twitter
    user.rep_phone = district.rep_phone
    user.save
  end
end

