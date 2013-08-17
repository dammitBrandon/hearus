class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :first_name
      t.string     :last_name
      t.string     :username
      t.string     :email, null: false
      t.string     :password_digest, null: false
      t.belongs_to :district
      t.integer    :district_number
      t.string     :state_name
      t.float      :latitude
      t.float      :longitude

      #denormalization
      t.string     :rep_name
      t.string     :rep_email_form
      t.string     :rep_party
      t.string     :rep_phone
      t.string     :rep_twitter
      t.string     :rep_facebook
      t.string     :rep_youtube
      t.string     :rep_wiki

      t.timestamps
    end
  end
end
