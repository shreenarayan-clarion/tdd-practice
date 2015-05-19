class CreateDeviceCategories < ActiveRecord::Migration
  def change
    create_table :device_categories do |t|
      t.string :name
      t.text :description
      t.integer :parent_id

      t.timestamps
    end
  end
end
