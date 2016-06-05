class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    @player_context = PlayerContext.new(current_user, @game)
    @presenter = GamePresenter.new(@game, @player_context)
  end

  def new
    @game = Game.new
    @opponent_email = ''
  end

  def create
    @opponent_email = params[:opponent]
    @opponent = User.find_by(email: @opponent_email)

    @game = Game.new
    @game.setup
    @game.users << current_user
    @game.users << @opponent if @opponent

    if @game.save
      redirect_to @game
    else
      render action: 'new'
    end
  end

  def submit_move
    @game = Game.find(params[:id])
    moved = @game.submit_move!(params[:start_position], params[:end_position], current_user)

    # save_move if moved #TODO: implement this
    Rails.logger.debug params.inspect

    redirect_to @game
  end

end
