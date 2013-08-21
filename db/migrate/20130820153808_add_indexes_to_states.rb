class AddIndexesToStates < ActiveRecord::Migration
  add_index :states, :abbreviation
end
