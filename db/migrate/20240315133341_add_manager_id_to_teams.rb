class AddManagerIdToTeams < ActiveRecord::Migration[5.2]
  def change
    add_reference :teams, :manager, foreign_key: { to_table: :employees }
  end
end
