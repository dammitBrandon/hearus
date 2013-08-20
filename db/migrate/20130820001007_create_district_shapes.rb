class CreateDistrictShapes < ActiveRecord::Migration
  def change
    create_table :district_shapes do |t|
      t.text :shape
      t.integer :district_id
    end
  end
end
