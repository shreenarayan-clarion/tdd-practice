class RenameColumnPurchaseQuotationId < ActiveRecord::Migration
  def change
    rename_column :device_transactions, :purchase_quotation_id, :quotation_id
  end
end
