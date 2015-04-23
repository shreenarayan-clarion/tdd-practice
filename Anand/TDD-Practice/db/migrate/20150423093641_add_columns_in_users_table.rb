class AddColumnsInUsersTable < ActiveRecord::Migration
  def up
    add_column :users, :email, :string, unique: true
    add_column :users, :password, :string
    add_column :users, :password_confirmation, :string
    add_column :users, :password_digest, :string
  end

  def down
    remove_column :users, :email
    remove_column  :users, :password
    remove_column :users, :password_confirmation
    remove_column  :users, :password_digest
  end
end
