class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.string :bill_id

      t.timestamps
    end
  end
end
