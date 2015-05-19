class CreateTransfers < ActiveRecord::Migration
  def change
    create_table :transfers do |t|
      t.integer :transferable_id
      t.string :transferable_type
      t.integer :from_location_id
      t.integer :to_location_id
      t.date :transfer_date
      t.integer :transferee_id

      t.timestamps
    end
  end
end
