class AddColumnToDeviceAssignments < ActiveRecord::Migration
  def change
    add_column :device_assignments, :unassign_date, :datetime
  end
end
