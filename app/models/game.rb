class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :users, :length => {:minimum => 2, :message=>"Invalid players" }

  ROW_INDICES = ('A'..'H').to_a.freeze
  COLUMN_INDICES = (1..8).to_a.freeze
  # first player is black, second player is red
  PLAYER_PIECE_MAPPINGS = %i(black red).freeze

  alias_method :players, :users

  def current_player
    User.find(self.current_player_id)
  end

  def color_for(player)
    player_ids = self.players.map(&:id)
    player_index = player_ids[player.id]

    PLAYER_PIECE_MAPPINGS[player_index]
  end

  def title
    "Game #{self.id}: " + players.map { |p| p.username }.join(" vs ")
  end

  def current_state
    human_readable_state(self.state || default_state)
  end

  # Set the game's starting conditions.
  # Eg - which player's turn it is
  def setup
    # For now, pick a random player.
    # In the future, alternate by series.
    self.current_player_id = self.players.sample.id
  end

  # Attempts to make a move and update the board.
  # Returns true if the move is valid, false otherwise.
  def submit_move!(start_position, end_position, player)
    player_context = PlayerContext.new(player, self)
    return false unless player_context.players_turn?
    return false unless move_valid?(start_position, end_position)

    update_board!(start_position, end_position, player)

    true
  end

  private

  def update_board!(start_position, end_position, player)
    # TODO: check for kings

  end

  def move_valid?
    true # TODO: implement me
  end

  def human_readable_state(encoded_state)
    values_map = %i(blank red black red_king black_king)
    encoded_state.map do |row|
      row.map { |value_index| values_map[value_index] }
    end
  end

  def default_state
    # zero represents a blank space
    # one represents a red checker
    # two represents a black checker
    # three represents a red king checker (not included in default state)
    # four represents a black king checker (not included in default state)
    [
      [0, 1, 0, 1, 0, 1, 0, 1],
      [1, 0, 1, 0, 1, 0, 1, 0],
      [0, 1, 0, 1, 0, 1, 0, 1],
      [0, 0, 0, 0, 0, 0, 0, 0],
      [0, 0, 0, 0, 0, 0, 0, 0],
      [2, 0, 2, 0, 2, 0, 2, 0],
      [0, 2, 0, 2, 0, 2, 0, 2],
      [2, 0, 2, 0, 2, 0, 2, 0]
    ]
  end


end
