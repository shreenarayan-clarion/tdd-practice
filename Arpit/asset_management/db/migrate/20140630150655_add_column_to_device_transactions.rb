class AddColumnToDeviceTransactions < ActiveRecord::Migration
  def change
    add_column :device_transactions, :request_quantity, :integer
  end
end
