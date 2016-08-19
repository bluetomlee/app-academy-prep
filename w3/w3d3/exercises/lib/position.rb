class Position
  attr_reader :x, :y

  def initialize(col, row)
    @x = row
    @y = col
  end

  def row
    @x
  end

  def col
    @y
  end

  def [](index)
    case index
    when 0 then return @y
    when 1 then return @x
    end
  end

  def coordinates
    [col, row]
  end

  def self.parse(input)
    input_col = input.slice(0)
    input_row = input.slice(1,2).to_i - 1

    if input_col && input_row
      input_col = input_col.upcase.ord - 65
      return Position.new(input_row, input_col)
    end

    nil
  end

  def valid?(board)
    max_width_index = board.width - 1
    max_height_index = board.height - 1
    (0..max_width_index).include?(@x) && (0..max_height_index).include?(@y)
  end

  def ==(pos)
    coordinates == pos.coordinates
  end

  def self.random_empty(board)
    board.empty_positions.sample
  end

  def surrounding_positions(board, options = {})
    positions = []

    p1 = Position.new(col, row + 1)
    p2 = Position.new(col, row - 1)
    p3 = Position.new(col + 1, row)
    p4 = Position.new(col - 1, row)

    positions << p1 unless options[:y_only] || !board.empty?(p1.coordinates) || !p1.valid?(board)
    positions << p2 unless options[:y_only] || !board.empty?(p2.coordinates) || !p2.valid?(board)
    positions << p3 unless options[:x_only] || !board.empty?(p3.coordinates) || !p3.valid?(board)
    positions << p4 unless options[:x_only] || !board.empty?(p4.coordinates) || !p4.valid?(board)

    positions
  end
end
