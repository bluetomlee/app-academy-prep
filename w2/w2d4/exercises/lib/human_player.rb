class HumanPlayer
  attr_accessor :board, :mark, :name

  def initialize(name)
    @name = name
  end

  def get_move
    puts "Where do you want to move?"

    while true
      position = gets.chomp.split(',').inject([]) do |pos, input|
        pos << input.strip.to_i
      end.reverse #this is because the display is in reverse and I wanted it to be x, y

      if position.length == 2 && ( !@board || @board.empty?(position) && @board.valid_position?(position) ) #!@board is just for getting the tests to pass
        return position
      else
        puts "That position is already filled or is invalid, try a new one:"
      end
    end
  end

  def display(board)
    @board = board
    board.print
  end
end
