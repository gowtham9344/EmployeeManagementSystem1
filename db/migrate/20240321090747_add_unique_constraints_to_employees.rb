class AddUniqueConstraintsToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_index :employees, :mobile, unique: true
    add_index :employees, :email, unique: true
  end
end
