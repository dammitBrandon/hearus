class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string  :first_name
      t.string  :last_name
      t.string  :username
      t.string  :email, null: false
      t.string  :password_digest, null: false

      t.integer :district_id
      t.string  :rep_name
      t.string  :rep_phone
      t.string  :rep_twitter

      t.timestamps
    end
  end
end
