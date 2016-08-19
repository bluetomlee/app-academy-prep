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
    [@x, @y]
  end

  def self.parse(input)
    col = input.slice(0)
    row = input.slice(1,2).to_i - 1

    if col && row
      col = col.upcase.ord - 65
      return Position.new(col, row)
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
end
