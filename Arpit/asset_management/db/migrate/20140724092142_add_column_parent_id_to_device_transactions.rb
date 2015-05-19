class AddColumnParentIdToDeviceTransactions < ActiveRecord::Migration
  def change
    add_column :device_transactions, :parent_id, :integer
  end
end
