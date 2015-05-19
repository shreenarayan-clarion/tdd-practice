class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :city
      t.string :state
      t.integer :contact_number
      t.integer :fax_number
      t.integer :mobile_number
      t.string :website
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
