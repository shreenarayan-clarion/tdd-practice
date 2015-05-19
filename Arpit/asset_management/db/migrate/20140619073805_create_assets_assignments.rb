class CreateAssetsAssignments < ActiveRecord::Migration
  def change
    create_table :assets_assignments do |t|
      t.references :asset, index: true
      t.references :employee, index: true
      t.date :assign_date

      t.timestamps
    end
  end
end
