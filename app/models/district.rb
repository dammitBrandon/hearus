class District < ActiveRecord::Base
  belongs_to :state
  has_many   :users

  attr_accessible :
  validates :rep_email_form, :rep_name,
            :rep_twitter, :rep_party,
            :rep_phone,:rep_wiki, :state_full_name,
            :state_id, :state_abbreviation,
            :presence => true, :on => :update

  def self.find_by_sunlight_district(district)
    District.where("state_abbreviation = ? AND number = ?", district.state, district.number.to_i ).first
  end
end
