class State < ActiveRecord::Base
  attr_accessible :abbreviation, :full_name
  has_many :districts
  has_many :users, :through => :districts

  validates :abbreviation, :full_name, :presence => true, :uniqueness => true
end
