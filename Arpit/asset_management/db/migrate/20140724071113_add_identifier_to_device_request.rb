class AddIdentifierToDeviceRequest < ActiveRecord::Migration
  def change
    add_column :device_requests, :identifier, :string
  end
end
