class HumanPlayer < Abstract
  attr_accessor :name, :board

  def initialize(options={})
    default_options = {
      name: ""
    }

    options = default_options.merge(options)

    @name = options[:name]
  end

  def pick_secret_word
    
  end

  def check_guess
  end

  def handle_response
  end

  def set_board(board)
    @board = board
  end

  def tell_word
  end

  def guess
    letter = nil

    until letter && letter.match(/^[a-zA-Z]$/)
      letter = prompt("               Guess a letter!")

      unless @board.not_guessed?(letter)
        puts "               I'm sorry, but you already guessed #{letter.upcase}, please try again!"
        letter = nil
      end
    end

    letter
  end
end
