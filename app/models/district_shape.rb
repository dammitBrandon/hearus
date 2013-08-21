class DistrictShape < ActiveRecord::Base
  belongs_to :district

  attr_accessible :district, :shape
end
