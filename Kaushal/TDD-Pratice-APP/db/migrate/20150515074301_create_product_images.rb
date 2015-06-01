class CreateProductImages < ActiveRecord::Migration
  def change
    create_table :product_images do |t|
      t.integer :product_id
      t.integer :category_id
      t.integer :image_height
      t.integer :image_width
      t.integer :image_x
      t.integer :image_y
      t.integer :product_theme_id
      t.integer :admin_id

      t.timestamps null: false
    end
  end
end
