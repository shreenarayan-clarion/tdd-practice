class AddColumnToEmployeeDeletedAt < ActiveRecord::Migration
  def change
    add_column :employees, :deleted_at, :datetime
  end
end
