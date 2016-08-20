require_relative 'abstract'
require_relative 'computer'
require_relative 'human'
require_relative 'board'

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
    @board = Board.new(@referee.pick_secret_word)
    @guesser.board = @board
    @referee.board = @board
    true
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
      @referee.check_guess(@guesser.guess)
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

  def end_game
    show_board
    puts "#{winner.name} won! Sorry #{loser.name}!"

    @referee.tell_word

    prompt("Press Enter to exit.")
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
