class Ship
  attr_accessor :start_pos, :end_pos, :length, :name, :hits

  def initialize(name, length = 2)
    @name = name
    @length = length
    @hits = []
  end

  def sunk?
    @hits.length == @length
  end

  def hit?(pos)
    @start_pos && @end_pos && x_range.include?(pos[0]) && y_range.include?(pos[1])
  end

  def place(start_pos, end_pos)
    @start_pos = start_pos.coordinates
    @end_pos = end_pos.coordinates
    raise "Ships can only be placed horizontally or vertically, not diagonally." unless horizontal? || vertical?
    raise "The length of the ship does not match the positions it was placed in." unless correct_length?
  end

  def hit(pos)
    @hits << pos if hit?(pos)
  end

  def placed?
    !!@start_pos && !!@end_pos
  end

  def available_end_positions(start_pos, board)
    positions = []

    possible_positions(start_pos).each do |position|
      positions << position if position.valid?(board) && !position_blocked?(board, start_pos, position)
    end

    positions
  end

  def possible_positions(start_pos)
    [
      Position.new(start_pos.col, start_pos.row - (@length - 1)),
      Position.new(start_pos.col, start_pos.row + (@length - 1)),
      Position.new(start_pos.col - (@length - 1), start_pos.row),
      Position.new(start_pos.col + (@length - 1), start_pos.row)
    ]
  end

  def x_range
    range(@start_pos[0], @end_pos[0])
  end

  def y_range
    range(@start_pos[1], @end_pos[1])
  end

  private
  def horizontal?
    @start_pos && @end_pos && @start_pos[1] == @end_pos[1]
  end

  def vertical?
    @start_pos && @end_pos && @start_pos[0] == @end_pos[0]
  end

  def range(start, stop)
    small = [start, stop].min
    large = [start, stop].max
    (small..large)
  end

  def correct_length?
    if horizontal?
      x_range.count == @length
    else
      y_range.count == @length
    end
  end

  def position_blocked?(board, start_pos, end_pos)
    if start_pos.col == end_pos.col
      range(start_pos.row, end_pos.row).any? do |num|
        pos = [num, start_pos.col]
        !board.empty?(pos) || board.has_ship?(pos)
      end
    else
      range(start_pos.col, end_pos.col).any? do |num|
        pos = [start_pos.row, num]
        !board.empty?(pos) || board.has_ship?(pos)
      end
    end
  end
end
