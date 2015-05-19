class CreateDeviceRequests < ActiveRecord::Migration
  def change
    create_table :device_requests do |t|
      t.string :title
      t.text :description
      t.references :device_category, index: true
      t.references :vendor, index: true
      t.date :on_date

      t.timestamps
    end
  end
end
