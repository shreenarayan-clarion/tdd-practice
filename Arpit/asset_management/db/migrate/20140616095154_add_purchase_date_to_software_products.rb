class AddPurchaseDateToSoftwareProducts < ActiveRecord::Migration
  def change
    add_column :software_products, :purchase_date, :datetime
  end
end
