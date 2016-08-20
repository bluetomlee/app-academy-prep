require_relative 'hangman'

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
