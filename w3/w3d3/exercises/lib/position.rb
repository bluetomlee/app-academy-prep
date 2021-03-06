class Position
  attr_reader :x, :y

  def initialize(col, row, board)
    @x = row
    @y = col
    @board = board
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

  def valid?
    max_width_index = @board.width - 1
    max_height_index = @board.height - 1
    (0..max_width_index).include?(@x) && (0..max_height_index).include?(@y)
  end

  def ==(pos)
    coordinates == pos.coordinates
  end

  def self.random_empty(board)
    board.empty_positions.sample
  end

  def empty?
    @board.empty?(coordinates)
  end

  def has_ship?
    @board.has_ship?(coordinates)
  end

  def surrounding_positions(options = {})
    default_options = {
      blocks_away: 1,
      path_clear: false
    }

    options = default_options.merge(options)

    positions = []

    positions += surrounding_x_positions(options[:blocks_away]) unless options[:y_only]
    positions += surrounding_y_positions(options[:blocks_away]) unless options[:x_only]

    positions.delete_if {|position| path_blocked?(position)} if options[:path_clear]

    positions
  end

  def surrounding_x_positions(blocks_away)
    positions = []

    p1 = Position.new(col, row + blocks_away, @board)
    p2 = Position.new(col, row - blocks_away, @board)

    positions << p1 unless !p1.empty? || !p1.valid?
    positions << p2 unless !p2.empty? || !p2.valid?

    positions
  end

  def surrounding_y_positions(blocks_away)
    positions = []

    p1 = Position.new(col + blocks_away, row, @board)
    p2 = Position.new(col - blocks_away, row, @board)

    positions << p1 unless !p1.empty? || !p1.valid?
    positions << p2 unless !p2.empty? || !p2.valid?

    positions
  end

  def path_blocked?(end_pos)
    if col == end_pos.col
      Helper.range(row, end_pos.row).any? do |num|
        pos = Position.new(col, num, @board)
        !pos.empty? || pos.has_ship?
      end
    else
      Helper.range(col, end_pos.col).any? do |num|
        pos = Position.new(num, row, @board)
        !pos.empty? || pos.has_ship?
      end
    end
  end
end
