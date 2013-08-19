class CreateRepresentatives < ActiveRecord::Migration
  def change
    create_table :representatives do |t|
    t.string :first_name
    t.string :middle_name
    t.string :last_name
    t.string :party
    t.string :state
    t.string :gender
    t.string :phone
    t.string :website
    t.string :webform
    t.string :congress_office
    t.string :bioguide_id
    t.string :votesmart_id
    t.string :twitter_id
    t.string :congresspedia_url
    t.string :youtube_url
    t.string :facebook_id
    t.string :birthday
    t.timestamps
    end
  end
end
