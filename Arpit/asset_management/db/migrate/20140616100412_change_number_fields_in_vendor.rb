class ChangeNumberFieldsInVendor < ActiveRecord::Migration
  def change
    change_column :vendors, :contact_number, :string
    change_column :vendors, :fax_number, :string
    change_column :vendors, :mobile_number, :string
  end
end
