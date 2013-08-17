class District < ActiveRecord::Base
  belongs_to :state
  has_many   :users

  validates :rep_email_form, :rep_name,
            :rep_twitter, :rep_party,
            :rep_phone,:rep_wiki, :state_name,
            :state_id,
            :presence => true, :on => :update

end
