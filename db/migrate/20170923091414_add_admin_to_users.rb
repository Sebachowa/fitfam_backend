class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :admin, :boolean, null: false, default: false
    remove_column :users, :is_admin, :boolean
  end
end
