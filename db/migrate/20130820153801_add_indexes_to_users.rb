class AddIndexesToUsers < ActiveRecord::Migration
  add_index :users, :district_number
  add_index :users, :state_abbreviation
end
