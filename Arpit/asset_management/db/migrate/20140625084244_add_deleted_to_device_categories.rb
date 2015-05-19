class AddDeletedToDeviceCategories < ActiveRecord::Migration
  def change
    add_column :device_categories, :deleted_at, :datetime
  end
end
