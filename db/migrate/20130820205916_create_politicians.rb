class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :party
      t.string  :gender
      t.string  :phone
      t.string  :website
      t.string  :webform
      t.string  :congress_office
      t.string  :bioguide_id
      t.string  :twitter_id
      t.string  :congresspedia_url
      t.string  :youtube_url
      t.string  :facebook_id
      t.string  :birthday
      t.string  :type
      t.integer :district_id, null: true
      t.integer :state_id, null: true

      t.timestamps
    end
  end
end
