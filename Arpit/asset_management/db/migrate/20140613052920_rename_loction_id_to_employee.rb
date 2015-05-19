class RenameLoctionIdToEmployee < ActiveRecord::Migration
  def change
	rename_column :employees, :location_id ,:branch_id
  end
end
