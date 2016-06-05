class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = current_user.games
  end

  def show
    @game = Game.find(params[:id])
    @presenter = GamePresenter.new(@game)
  end

  def new
    @game = Game.new
    @opponent_email = ''
  end

  def create
    @opponent_email = params[:opponent]
    @opponent = User.find_by(email: @opponent_email)

    @game = Game.new
    @game.users << current_user
    @game.users << @opponent if @opponent

    if @game.save
      redirect_to @game
    else
      render action: 'new'
    end
  end
end
