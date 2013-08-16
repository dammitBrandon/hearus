class District < ActiveRecord::Base
  belongs_to :state
  has_many   :users

  validates :rep_name, :rep_twitter, :rep_party,
            :rep_twitter, :rep_phone, :rep_term_start,
            :rep_term_end, :rep_years_in_congress,
            :state_name, :presence_true

end
