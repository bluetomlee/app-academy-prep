class Code
  attr_reader :pegs

  PEGS = {
    :red => 'r',
    :green => 'g',
    :blue => 'b',
    :yellow => 'y',
    :orange => 'o',
    :purple => 'p'
  }

  def initialize(pegs)
    @pegs = pegs
  end

  def [](index)
    @pegs[index]
  end

  def self.parse(code)
    code = code.downcase.chars

    raise if code.any? {|letter| !PEGS.value?(letter)}
    raise if code.length != 4

    Code.new(code)
  end

  def self.random
    Code.new( Code.random_code )
  end

  def exact_matches(code)
    @pegs.each_with_index.inject(0) do |total, (peg, index)|
      total += 1 if code[index] == peg
      total
    end
  end

  def near_matches(code)
    matches = code.pegs.uniq.inject(0) do |total, peg|
      total + [code.pegs.count_if(peg), @pegs.count_if(peg)].min
    end

    matches - exact_matches(code)
  end

  def ==(code)
    code.instance_of?(Code) && @pegs == code.pegs
  end

  def to_s
    @pegs.join.upcase
  end

  private
  def self.random_code
    Array.new(4).inject([]) {|code| code << PEGS.values.shuffle.pop}
  end
end

class Game
  attr_reader :secret_code

  def initialize(code = Code.random)
    @secret_code = code
    @guesses = 0
    @max_guesses = 10
    @current_guess = nil
    @losses = 0
    @wins = 0
  end

  def play
    instructions

    until won? || lost?
      @current_guess = get_guess
      display_matches
    end

    end_game
  end

  def get_guess
    increment_guesses
    begin
      Code.parse(prompt("Guess a code:"))
    rescue
      invalid_guess
    end
  end

  def display_matches(code=@current_guess)
    puts "#{@secret_code.exact_matches(code)} exact matches"
    puts "#{@secret_code.near_matches(code)} near matches"
  end

  private
  def prompt(message)
    puts message
    gets.chomp
  end

  def invalid_guess
    puts "You entered an invalid code."
    instructions
    get_guess
  end

  def instructions
    puts "Try to guess the code, it is made up of four colors."
    puts "The possible colors are: #{Code::PEGS.keys.take(Code::PEGS.keys.length - 1).join(', ')}, and #{Code::PEGS.keys.last}."
    puts "Use the first letter of each color for your guesses."
    puts "For example to guess \"green green red blue\" you would enter \"ggrb\"."
  end

  def introduction
    instructions
    puts "You get a maximum of #{@max_guesses} guesses."
    puts "Good luck!"
  end

  def increment_guesses
    @guesses += 1
  end

  def increment_wins
    @wins += 1
  end

  def increment_losses
    @losses += 1
  end

  def won?
    @current_guess == @secret_code
  end

  def lost?
    !won? && @guesses >= @max_guesses
  end

  def end_game
    win if won?
    lose if lost?

    show_stats if @wins + @losses > 1
    new_game if prompt("Do you want to play again? Enter Y for yes, anything else for no.").downcase == 'y'
  end

  def win
    increment_wins
    puts "Congratulations, you correctly guessed the code was #{@secret_code} in #{@guesses} guesses!"
  end

  def lose
    increment_losses
    puts "Sorry, you lose!  You used up all of your #{@max_guesses} guesses without correctly guessing the code was #{@secret_code}."
  end

  def show_stats
    puts "You haven't won a single game, but you've lost #{@losses} game#{@losses > 1 ? 's':''}!" if @wins == 0
    puts "You've won #{@wins} game#{@wins > 1 ? 's':''} and haven't lost any!" if @wins > 0 && @losses == 0
    puts "You've won #{@wins} game#{@wins > 1 ? 's':''} and lost #{@losses} game#{@losses > 1 ? 's':''}!" if @wins > 0 && @losses > 0
  end

  def new_game
    @secret_code = Code.random
    @guesses = 0
    play
  end
end

class Array
  def count_if(value)
    self.count { |e| e == value }
  end
end
