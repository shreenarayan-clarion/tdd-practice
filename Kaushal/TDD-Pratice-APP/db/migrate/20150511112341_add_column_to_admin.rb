class AddColumnToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :created_by_id, :integer
  end
end
