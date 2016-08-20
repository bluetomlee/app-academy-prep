class ComputerPlayer < Abstract
  attr_accessor :name, :word, :board, :dictionary, :candidate_words, :wins

  def initialize(options={})
    default_options = {
      dictionary: default_dictionary,
      name: ""
    }

    options = default_options.merge(options)

    @dictionary = options[:dictionary]
    @name = options[:name]
    @candidate_words = options[:dictionary]
    @wins = 0
  end

  def reset_candidate_words
    @candidate_words = @dictionary
  end

  def new_game
    reset_candidate_words
  end

  def pick_secret_word
    @word = @dictionary.sample.chomp.upcase

    @word.length
  end

  def set_board(board)
    @board = board
  end

  def tell_word
    puts "The word was: #{@word}"
  end

  def update_candidate_words
    @candidate_words.delete_if do |word|
      word = word.upcase.chomp
      delete = false
      delete = true if word.length != @board.word_length

      word.chars.each_with_index do |letter, index|
        delete = true if @board.word[index] && @board.word[index] != letter
        delete = true if @board.word[index] != letter && @board.word.any? {|l| l == letter}
      end

      @board.missed_letters.each do |letter|
        delete = true if word.match(letter)
      end

      delete
    end
  end

  def most_common_letter
    letters = {}

    @candidate_words.each do |word|
      word.upcase.chars.each do |letter|
        if letter.match(/^[A-Z]$/) && @board.not_guessed?(letter)
          letters[letter] = letters[letter].to_i + 1
        end
      end
    end

    most_common = letters.max_by{|k,v| v}

    if most_common
      most_common[0]
    else
      nil
    end
  end

  def increment_wins
    @wins += 1
  end

  def check_guess(letter)
    indexes = []

    @word.chars.each_with_index do |char, index|
      indexes << index if char == letter.upcase
    end

    @board.fill_in_letter(letter.upcase, indexes) if @board

    indexes
  end

  def handle_response
  end

  def random_guess
    letter = nil

    until letter
      letter = ("A".."Z").to_a.sample

      letter = nil if !@board.not_guessed?(letter)
    end

    letter
  end

  def guess
    update_candidate_words
    letter = most_common_letter

    letter = random_guess if !letter || !letter.match(/^[A-Za-z]$/)

    letter
  end

  private
  def default_dictionary
    file = File.join(File.dirname(__FILE__), 'dictionary.txt')
    File.open(file) do |f|
      return f.readlines
    end
  end
end
