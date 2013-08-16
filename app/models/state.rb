class State < ActiveRecord::Base
  has_many :districts
  has_many :users, :through => :districts

  validates :name, :presence => true
end
