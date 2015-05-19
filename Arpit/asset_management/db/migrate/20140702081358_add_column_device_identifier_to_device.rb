class AddColumnDeviceIdentifierToDevice < ActiveRecord::Migration
  def change
    add_column :devices, :device_identifier, :string
    remove_column :devices, :name
  end
end
