class CreateVotes < ActiveRecord::Migration
 def change
  create_table :votes do |t|
    t.string     :choice
    t.belongs_to :user
    t.string     :sunlight_id
    t.integer    :tweeted
    t.datetime   :tweeted_at

    t.timestamps
  end
 end
end
