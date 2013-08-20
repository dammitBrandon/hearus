class AddIndexesToDistricts < ActiveRecord::Migration
  add_index :districts, :number
  add_index :districts, :state_abbreviation
  add_index :districts, :bioguide_id
end


