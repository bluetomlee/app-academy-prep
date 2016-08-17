# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  game = GuessGame.new
  game.play
end

class GuessGame
  attr_accessor :guesses, :current_guess, :answer

  def initialize
    @guesses = 0
    @answer = rand(1..100)
    @current_guess = 0
  end

  def play
    until just_right? || @guesses > 100
      guess
      puts "That's too high!" if too_high?
      puts "That's too low!" if too_low?
    end

    puts "You won!"
  end

  def guess
    @current_guess = prompt("guess a number")
    @current_guess = @current_guess.chomp.to_i if @current_guess
    increment_guesses
  end

  def too_high?
    @current_guess > @answer && @current_guess
  end

  def too_low?
    @current_guess < @answer && @current_guess
  end

  def just_right?
    @current_guess == @answer
  end

  private
  def prompt(message)
    puts message
    gets
  end

  def increment_guesses
    @guesses += 1
  end
end

#I like the version above better, but it doesn't pass the tests because of the gets crap
def guessing_game
  guesses = 0
  answer = rand(1..100)
  guess = nil

  until guess == answer
    puts "guess a number"
    guess = gets.chomp.to_i

    puts "#{guess} is too high" if guess > answer
    puts "#{guess} is too low" if guess < answer

    guesses += 1
  end

  puts "#{answer} was the correct answer! It took you #{guesses} guesses to come up with that!"
end

def shuffle_file
  puts "Enter file name:"
  file_name = gets.chomp

  File.open("#{file_name}.txt") do |f|
    File.open("#{file_name}-shuffle.txt", "w") do |nf|
      f.readlines.shuffle.each {|line| nf.puts line}
    end
  end
end
