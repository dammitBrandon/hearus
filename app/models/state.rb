class State < ActiveRecord::Base
  attr_accessible :abbreviation, :full_name
  has_many :districts
  has_many :representatives
  has_many :senators
  has_many :users
  has_many :politicians
  validates :abbreviation, :full_name, :presence => true, :uniqueness => true
end
