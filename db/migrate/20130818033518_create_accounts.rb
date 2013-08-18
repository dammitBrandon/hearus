class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :user
      t.string :uid
      t.string :username
      t.string :oauth_token
      t.string :oauth_secret
      t.datetime :oauth_expires

      t.timestamps
    end
    add_index :accounts, :user_id
  end
end
