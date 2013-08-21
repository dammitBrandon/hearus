class District < ActiveRecord::Base
  has_one    :representative
  belongs_to :state
  has_many   :users

  validates :state_full_name, :rep_name,
            :state_id, :state_abbreviation,
            :presence => true, :on => :update

  def self.find_by_sunlight_district(district)
    District.where("state_abbreviation = ? AND number = ?", district.state, district.number.to_i ).first
  end
end
