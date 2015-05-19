class RenameAssetCategoryIdToDeviceCategoryId < ActiveRecord::Migration
  def change
    rename_column :software_products, :assets_category_id ,:device_category_id
  end
end
