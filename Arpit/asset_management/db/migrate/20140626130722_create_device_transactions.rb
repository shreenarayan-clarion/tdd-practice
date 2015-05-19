class CreateDeviceTransactions < ActiveRecord::Migration
  def change
    create_table :device_transactions do |t|
      t.references :vendor, index: true
      t.references :device_category, index: true
      t.float :vat
      t.boolean :accepted
      t.integer :invoice_id
      t.integer :purchase_order_id
      t.integer :purchase_quotation_id
      t.references :device_request, index: true
      t.string :request_title
      t.string :quotation_title
      t.string :purchase_title
      t.string :invoice_title
      t.string :request_description
      t.string :quotation_description
      t.string :purchase_description
      t.string :invoice_description
      t.string :quotation_price
      t.string :purchase_price
      t.string :invoice_price
      t.string :quotation_quantity
      t.string :purchase_quantity
      t.string :invoice_quantity

      t.timestamps
    end
  end
end
