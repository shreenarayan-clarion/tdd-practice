class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.references :invoice, index: true
      t.references :vendor, index: true
      t.string :serial_number
      t.string :model_number
      t.string :ip_address
      t.string :status
      t.datetime :status_date
      t.references :branch, index: true
      t.string :warranty
      t.string :provider
      t.string :client_name
      t.integer :device_category_id, index: true
      t.integer :parent_id
      t.references :employee, index: true
      t.datetime :deleted_at
      t.date :purchase_date

      t.timestamps
    end
  end
end
