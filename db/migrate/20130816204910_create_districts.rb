class CreateDistricts < ActiveRecord::Migration
  def change
    create_table :districts do |t|
      t.integer    :number
      t.belongs_to :state
      t.string     :state_abbreviation
      t.string     :state_full_name
      t.string     :rep_name

      t.timestamps
    end
  end
end
