class AddRoleColumnToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :role, :integer, default: 2
    add_column :admins, :name, :string
  end
end
