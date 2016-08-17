require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_accessor :board, :players

  def initialize(player_one, player_two)
    @board = Board.new

    player_one.mark = :X
    player_two.mark = :O

    @players = [
      player_one,
      player_two
    ]

    @turn = 0
  end

  def play
    @board.reset

    until @board.winner
      play_turn
    end

    @board.print

    puts "Congratulations #{winner.name}! You won!"
  end

  def play_turn
    current_player.display( @board )
    make_move
    switch_players!
  end

  def current_player
    @players[ @turn ]
  end

  def switch_players!
    case @turn
    when 0 then @turn = 1
    when 1 then @turn = 0
    end
  end

  private
  def make_move
    @board.place_mark(current_player.get_move, current_player.mark)
  end

  def winner
    @players.select{ |player| player.mark == @board.winner }[0]
  end
end
