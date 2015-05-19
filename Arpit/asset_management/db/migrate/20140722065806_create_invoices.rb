class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.string :identifier
      t.references :purchase_order, index: true
      t.date :on_date

      t.timestamps
    end
  end
end
