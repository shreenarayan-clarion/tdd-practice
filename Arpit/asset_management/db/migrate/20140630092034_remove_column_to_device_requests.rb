class RemoveColumnToDeviceRequests < ActiveRecord::Migration
  def change
    remove_column :device_requests, :vendor_id, :string
  end
end
