class AddStateToGames < ActiveRecord::Migration
  def change
    add_column :games, :state, :integer, array: true
  end
end
