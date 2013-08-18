class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.integer    :number
      t.belongs_to :state
      t.string     :state_abbreviation
      t.string     :state_full_name

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
