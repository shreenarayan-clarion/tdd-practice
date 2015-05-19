class CreateDeviceAssignments < ActiveRecord::Migration
  def change
    create_table :device_assignments do |t|
      t.integer :device_id, index: true
      t.references :employee, index: true
      t.date :assign_date
      t.timestamps
    end
  end
end
