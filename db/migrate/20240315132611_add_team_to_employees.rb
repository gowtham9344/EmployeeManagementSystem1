class AddTeamToEmployees < ActiveRecord::Migration[5.2]
  def change
    add_reference :employees, :team, foreign_key: true
  end
end
