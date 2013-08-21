class AddIndexesToVotes < ActiveRecord::Migration
  add_index :votes, :sunlight_id
  add_index :votes, :choice
end
