class Game < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :users, :length => {:minimum => 2, :message=>"Invalid players" }

  ROW_INDICES = ('A'..'H').to_a.freeze
  COLUMN_INDICES = (1..8)

  alias_method :players, :users

  def title
    "Game #{self.id}: " + players.map { |p| p.username }.join(" vs ")
  end

  def current_state
    human_readable_state(self.state || default_state)
  end

  private

  def human_readable_state(encoded_state)
    values_map = [:blank, :red, :black]
    encoded_state.map do |row|
      row.map { |value_index| values_map[value_index] }
    end
  end

  def default_state
    # zero represents a blank space
    # one represents a light checker (red)
    # two represents a dark checker (black)
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
