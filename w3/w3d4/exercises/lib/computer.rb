class ComputerPlayer < Abstract
  attr_accessor :name, :word, :board, :dictionary

  def initialize(options={})
    default_options = {
      dictionary: default_dictionary,
      name: ""
    }

    options = default_options.merge(options)

    @dictionary = options[:dictionary]
    @name = options[:name]
  end

  def pick_secret_word
    @word = dictionary.sample.chomp.upcase

    @word.length
  end

  def tell_word
    puts "The word was: #{@word}"
  end

  def check_guess(letter)
    indexes = []

    @word.chars.each_with_index do |char, index|
      indexes << index if char == letter.upcase
    end

    @board.fill_in_letter(letter.upcase, indexes)

    indexes
  end

  def handle_response
  end

  def guess
  end

  private
  def default_dictionary
    file = File.join(File.dirname(__FILE__), 'dictionary.txt')
    File.open(file) do |f|
      return f.readlines
    end
  end
end
