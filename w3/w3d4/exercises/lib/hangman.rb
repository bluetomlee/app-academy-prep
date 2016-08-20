require_relative 'abstract'
require_relative 'computer'
require_relative 'human'
require_relative 'board'
require 'byebug'

class Hangman < Abstract
  attr_reader :guesser, :referee, :board

  def initialize(players)
    @guesser = players[:guesser]
    @referee = players[:referee]
  end

  def play
    setup
    guess
  end

  def setup
    word_length = @referee.pick_secret_word

    @board = Board.new(word_length)
    @guesser.set_board(@board)
    @referee.set_board(@board)
  end

  def take_turn
    @referee.check_guess(@guesser.guess)
  end

  private
  def self.introduction
    Hangman.display_title
    puts
    Hangman.display_hung_man
  end

  def guess
    until game_over?
      show_board
      take_turn
    end

    end_game
  end

  def show_board
    @board.print
  end

  def game_over?
    @board.solved? || @board.lost?
  end

  def winner
    @board.solved? ? @guesser : @referee
  end

  def loser
    @board.lost? ? @guesser : @referee
  end

  def new_game
    @referee.new_game
    @guesser.new_game
    play
  end

  def show_stats
    puts
    puts "The referee, #{@referee.name}, has won #{@referee.wins} time#{@referee.wins == 1 ? "":"s"}."
    puts "The guesser, #{@guesser.name}, has won #{@guesser.wins} time#{@guesser.wins == 1 ? "":"s"}."
    puts
  end

  def games_played
    @referee.wins + @guesser.wins
  end

  def end_game
    show_board
    puts "#{winner.name} won! Sorry #{loser.name}!"

    @referee.tell_word

    winner.increment_wins

    show_stats if games_played > 1

    if prompt("Do you want to play again? Enter Y for yes, anything else for no.").downcase == 'y'
      new_game
    else
      prompt("Press Enter to exit.")
    end
  end

  def self.display_title
    puts [
      "                         ",
      "                         ",
      "88                                                                            ",
      "88                                                                            ",
      "88                                                                            ",
      "88,dPPYba,  ,adPPYYba, 8b,dPPYba,   ,adPPYb,d8 88,dPYba,,adPYba,  ,adPPYYba,  8b,dPPYba,  ",
      "88P'    \"8a \"\"     `Y8 88P'   `\"8a a8\"    `Y88 88P'   \"88\"    \"8a \"\"     `Y8  88P'   `\"8a  ",
      "88       88 ,adPPPPP88 88       88 8b       88 88      88      88 ,adPPPPP88  88       88  ",
      "88       88 88,    ,88 88       88 \"8a,   ,d88 88      88      88 88,    ,88  88       88  ",
      "88       88 `\"8bbdP\"Y8 88       88  `\"YbbdP\"Y8 88      88      88 `\"8bbdP\"Y8  88       88  ",
      "                                    aa,    ,88                                ",
      "                                     \"Y8bbdP\"                                  ",
      "                                     ",
      "                                     ",
    ].join("\n")
  end

  def self.display_hung_man
    puts [
      "                                  ___________.._______",
      "                            | .__________))______|",
      "                            | | / /      ||",
      "                            | |/ /       ||",
      "                            | | /        ||.-''.",
      "                            | |/         |/  _  \\",
      "                            | |          ||  `/,|",
      "                            | |          (\\\\`_.'",
      "                            | |         .-`--'.",
      "                            | |        /Y . . Y\\",
      "                            | |       // |   | \\\\",
      "                            | |      //  | . |  \\\\",
      "                            | |     ')   |   |   (`",
      "                            | |          ||'||",
      "                            | |          || ||",
      "                            | |          || ||",
      "                            | |          || ||",
      "                            | |         / | | \\",
      "                            \"\"\"\"\"\"\"\"\"\"|_`-' `-' |\"\"\"|",
      "                            |\"|\"\"\"\"\"\"\"\\ \\       '\"|\"|",
      "                            | |        \\ \\        | |",
      "                            : :         \\ \\       : :  ",
      "                            . .          `'       . ."
    ].join("\n")
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

  def set_up_player(role)
    type = nil
    until [1,2].include?(type)
      type = prompt("What type of player is the #{role}? Enter 1 for human, 2 for computer.").to_i
    end

    player = nil

    case type
    when 1 then player = HumanPlayer.new(name: prompt("What is the #{role}'s name?"))
    when 2 then player = ComputerPlayer.new(name: random_computer_name)
    end

    puts "The #{role} is #{player.name}, good luck!"
    player
  end

  Hangman.introduction

  game = Hangman.new(guesser: set_up_player("guesser"), referee: set_up_player("referee"))
  game.play
end
