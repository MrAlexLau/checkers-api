class AddCurrentPlayerToGames < ActiveRecord::Migration
  def self.up
    add_column :games, :current_player_id, :integer

    Game.all.each do |game|
      game.current_player_id = game.players.first.id
      game.save
    end

    change_column_null(:games, :current_player_id, false)
  end

  def self.down
    remove_column :games, :current_player_id
  end
end
