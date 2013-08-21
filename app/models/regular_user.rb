class RegularUser < User
  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                    message: "%{value} is not a valid email address." }
  validates_presence_of :password
end


