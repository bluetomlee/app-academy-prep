require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'
require 'byebug'

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
    #debugger
    @board.reset

    until @board.winner || @board.none?
      play_turn
    end

    @board.print

    puts "Congratulations #{winner.name}! You won!" if @board.winner
    puts "It was a draw!" if !@board.winner
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

if __FILE__ == $PROGRAM_NAME
  def prompt( message )
    puts message
    gets.chomp
  end

  RANDOM_NAMES = [
    "Robo the robot",
    "Andy the android",
    "Zeke"
  ]

  def random_computer_name
    RANDOM_NAMES.shuffle!.pop
  end

  def set_up_player(num)
    type = nil
    until [1,2].include?(type)
      type = prompt("What type of player is player #{num}? Enter 1 for human, 2 for computer.").to_i
    end

    player = nil

    case type
    when 1 then player = HumanPlayer.new(prompt("What is player #{num}'s name?"))
    when 2 then player = ComputerPlayer.new(random_computer_name)
    end

    puts "Player #{num} is #{player.name}, good luck!"
    puts
    puts
    player
  end

  game = Game.new(set_up_player("one"), set_up_player("two"))
  game.play
end
