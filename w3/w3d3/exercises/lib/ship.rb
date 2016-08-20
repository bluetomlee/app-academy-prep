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

  def available_end_positions(start_pos)
    start_pos.surrounding_positions(path_clear: true, blocks_away: @length - 1)
  end

  def x_range
    Helper.range(@start_pos[0], @end_pos[0])
  end

  def y_range
    Helper.range(@start_pos[1], @end_pos[1])
  end

  private
  def horizontal?
    @start_pos && @end_pos && @start_pos[1] == @end_pos[1]
  end

  def vertical?
    @start_pos && @end_pos && @start_pos[0] == @end_pos[0]
  end

  def correct_length?
    if horizontal?
      x_range.count == @length
    else
      y_range.count == @length
    end
  end
end
