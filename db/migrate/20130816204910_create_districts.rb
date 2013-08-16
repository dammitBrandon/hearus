class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.belongs_to :state
      t.string     :state_name
      t.string     :rep_name
      t.string     :rep_twitter
      t.string     :rep_party
      t.string     :rep_phone
      t.string     :rep_term_start
      t.string     :rep_term_end
      t.string     :rep_years_in_congress

      t.timestamps
    end
  end
end
