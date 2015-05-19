class CreateSoftwareProducts < ActiveRecord::Migration
  def change
    create_table :software_products do |t|
      t.string :name
      t.text :description
      t.references :assets_category, index: true
      t.string :version
      t.boolean :license
      t.string :license_no

      t.timestamps
    end
  end
end
