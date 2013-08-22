class RegularUser < User
  attr_accessible :password, :password_confirmation
  has_secure_password

  validates :email, :password, presence: true
  validates :email, uniqueness: { case_sensitive: false },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
                    message: "%{value} is not a valid email address." }
end
