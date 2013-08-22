class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string     :first_name
      t.string     :last_name
      t.string     :username
      t.string     :password_digest
      t.string     :email
      t.belongs_to :district
      t.integer    :district_number
      t.integer    :state_id
      t.string     :state_abbreviation

      t.timestamps
    end
  end
end
