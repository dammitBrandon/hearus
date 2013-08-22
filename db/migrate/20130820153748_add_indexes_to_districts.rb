class AddIndexesToDistricts < ActiveRecord::Migration
  add_index :districts, :number
  add_index :districts, :state_abbreviation
end


