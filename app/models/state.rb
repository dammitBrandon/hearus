class State < ActiveRecord::Base
  attr_accessible :name
  has_many :districts
  has_many :users, :through => :districts

  validates :name, :presence => true, :uniqueness => true
end
