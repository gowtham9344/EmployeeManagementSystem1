class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :email
      t.text :address
      t.string :mobile
      t.boolean :is_manager

      t.timestamps
    end
    add_index :employees, :name
  end
end
