class AddColumnDeletedAt < ActiveRecord::Migration
  def change
    add_column :software_products, :deleted_at, :datetime
  end
end
