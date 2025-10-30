class AddRoleAndNameToAdmins < ActiveRecord::Migration[8.0]
  def change
    add_column :admins, :role, :string, default: 'student', null: false
    add_column :admins, :name, :string
    add_index :admins, :role
  end
end
