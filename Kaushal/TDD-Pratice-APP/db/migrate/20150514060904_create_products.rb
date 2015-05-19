class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :shopify_product_id
      t.string :name
      t.float :base_price
      t.string :image
      t.text :description
      t.boolean :active, default: true
      t.integer :admin_id
      t.integer :parent_id
      t.timestamps
    end
  end
end
