class CreatePurchaseOrders < ActiveRecord::Migration
  def change
    create_table :purchase_orders do |t|
      t.string :identifier
      t.references :quotation, index: true
      t.date :on_date

      t.timestamps
    end
  end
end
