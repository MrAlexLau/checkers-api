class GamePresenter
  attr_accessor :game, :player_context

  def initialize(a_game, context)
    self.game = a_game
    self.player_context = context
  end

  def rows
    result = []

    game.current_state.each_with_index do |row, row_index|
      new_row = OpenStruct.new()

      new_row.css = row_index.even? ? 'game-row-even' : 'game-row-odd'
      new_row.squares = get_squares(row)
      result << new_row
    end

    result
  end

  def header_row
    new_row = OpenStruct.new({
      css: 'header-row',
      squares: []
    })

    Game::COLUMN_INDICES.each do |col_index|
      new_row.squares << OpenStruct.new({
        value: col_index,
        css: 'legend-square square'
      })
    end

    new_row
  end

  private

  def get_squares(row)
    result = []

    row.map do |checker_value|
      new_square = OpenStruct.new()
      new_square.css = ['square', checker_value]
      new_square.css << 'current-players-checker' if player_context.players_turn? && checker_value == player_context.players_color

      new_square.value = ''

      result << new_square
    end

    result
  end
end