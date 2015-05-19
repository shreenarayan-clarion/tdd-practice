class AddNotesToDeviceTransactions < ActiveRecord::Migration
  def change
    add_column :device_transactions, :quotation_notes, :string
    add_column :device_transactions, :purchase_notes, :string
    add_column :device_transactions, :invoice_notes, :string
  end
end
