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
    length = false

    until length
      puts "Think of a word for your opponent to guess."
      length = prompt("How many letters are in your chosen word?")

      length = nil unless length.match(/^[0-9]+$/)
    end

    length.to_i
  end

  def check_guess(letter)
    input = prompt("Are there any \"#{letter}\"s in your word? Enter Y for yes or anything else for no.")

    if input.upcase == "Y"
      puts "Enter the numbers of the spots where the letter \"#{letter}\" goes separated by commas (ex. 1,2,5)"
      @board.display_word(true)

      spots = nil

      until spots
        spots = gets.chomp.gsub(" ","")

        spots = nil unless spots.match(/^[0-9,]+$/)

        if spots
          spots = spots.split(',').map(&:to_i).select {|num| num <= @board.blank_spaces && num > 0}
        end

        spots = nil unless spots.length > 0

        puts "That was an invalid entry, please try again: " unless spots
      end
    else
      spots = []
    end

    indexes = spots.map {|e| @board.index_of_blank_spot(e)}

    @board.fill_in_letter(letter.upcase, indexes) if @board

    indexes
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
