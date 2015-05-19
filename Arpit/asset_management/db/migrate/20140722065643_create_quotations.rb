class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.string :identifier
      t.references :device_request, index: true
      t.date :on_date

      t.timestamps
    end
  end
end
