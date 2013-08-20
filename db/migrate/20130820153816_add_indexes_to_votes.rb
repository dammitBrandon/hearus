class AddIndexesToVotes < ActiveRecord::Migration
  add_index :votes, :bill_id
  add_index :votes, :choice
end
