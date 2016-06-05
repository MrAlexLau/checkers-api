class PlayerContext
  attr_accessor :player, :game, :players_turn, :players_color
  alias_method :players_turn?, :players_turn
  def initialize(a_player, a_game)
    self.player = a_player
    self.game = a_game

    set_context!
  end

  private

  def set_context!
    self.players_turn = (game.current_player.id == player.id)
    self.players_color = game.color_for(player)
  end
end