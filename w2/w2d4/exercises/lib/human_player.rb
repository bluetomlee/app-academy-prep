class HumanPlayer
  attr_accessor :board, :mark, :name

  def initialize(name)
    @name = name
  end

  def get_move
    puts "Where do you want to move?"

    gets.chomp.split(',').inject([]) do |pos, input|
      pos << input.strip.to_i
    end
  end

  def display(board)
    board.print
  end
end
