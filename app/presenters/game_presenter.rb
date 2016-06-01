class GamePresenter
  attr_accessor :game

  def initialize(a_game)
    self.game = a_game
  end

  def rows
    result = []

    game.current_state.each_with_index do |row, row_index|
      new_row = OpenStruct.new()

      new_row.css_class = row_index.even? ? 'game-row-even' : 'game-row-odd'
      new_row.squares = get_squares(row)
      result << new_row
    end

    result
  end

  private

  def get_squares(row)
    result = []

    row.map do |square|
      new_square = OpenStruct.new()
      new_square.css_class = "square #{square}"

      result << new_square
    end

    result
  end
end