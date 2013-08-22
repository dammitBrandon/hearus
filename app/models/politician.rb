class Politician < ActiveRecord::Base

  attr_accessible :first_name, :middle_name,
                  :last_name, :party, :state_id,
                  :district_id, :gender, :phone,
                  :fax, :website, :webform,
                  :congress_office, :bioguide_id,
                  :twitter_id, :congresspedia_url, :youtube_url,
                  :facebook_id, :birthday

  validates_presence_of :first_name, :last_name, :party,
                        :bioguide_id, :gender, :phone, :birthday
end
