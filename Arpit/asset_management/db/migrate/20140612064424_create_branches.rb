class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.integer :parent_id
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
