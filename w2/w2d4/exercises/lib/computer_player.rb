class ComputerPlayer
  attr_accessor :board, :mark, :name

  def initialize(name)
    @name = name
  end

  def display( board )
    @board = board
  end

  def get_move
    return winning_move if winning_move
    return blocking_move if blocking_move

    @board.empty_positions.shuffle.first
  end

  private
  def winning_move
    move = nil

    @board.empty_positions.each do |pos|
      place_mark( pos )
      move = pos if @board.winner
      unmark( pos )
    end

    move
  end

  def blocking_move
    move = nil

    @board.empty_positions.each do |pos|
      @board.place_mark(pos, opponent_mark)
      move = pos if @board.winner
      unmark( pos )
    end

    move
  end

  def place_mark(pos)
    @board.place_mark(pos, @mark)
  end

  def opponent_mark
    case @mark
    when :X then return :O
    when :O then return :X
    end
  end

  def unmark(pos)
    @board.unmark(pos)
  end
end
