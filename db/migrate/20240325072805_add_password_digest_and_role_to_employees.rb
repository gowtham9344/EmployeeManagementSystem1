class AddPasswordDigestAndRoleToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_column :employees, :password_digest, :string
    add_column :employees, :role, :string
  end
end
