class Board
  attr_accessor :grid

  def initialize(grid = nil)
    @grid = grid || Array.new(3) { Array.new(3) }
  end

  def [](row, col)
    @grid[row][col] if @grid[row]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def place_mark(pos, mark)
    self[*pos] = mark if empty?(pos) && valid_position?(pos)
  end

  def unmark(pos)
    self[*pos] = nil
  end

  def empty?(pos)
    self[*pos].nil?
  end

  def valid_position?(pos)
    pos[0] < @grid.length && pos[1] < @grid[0].length
  end

  def winner
    return row_winner if row_winner
    return column_winner if column_winner
    return self[0,0] if left_diagonal_win?
    return self[-1,0] if right_diagonal_win?

    nil
  end

  def over?
    !winner.nil? || none?
  end

  def none?
    @grid.none? {|row| row.any?(&:nil?)}
  end

  def empty_positions
    positions = []

    @grid.each_with_index do |row, index|
      row.each_with_index do |spot, index2|
        positions << [index, index2] if spot.nil?
      end
    end

    positions
  end

  def print
    display_rows = []

    @grid.each do |row|
      display_items = []

      row.each do |item|
        display_items << item if item
        display_items << " " unless item
      end

      display_rows << display_items.join(' | ')
    end

    puts display_rows.join("\n---------\n")
  end

  def reset
    @grid = Array.new(3) { Array.new(3) }
  end

  private
  def column_winner
    @grid[0].each_with_index do |spot, index|
      if spot
        column_win = true

        @grid.each do |row|
          column_win = false if row[index] != spot
        end

        return spot if column_win
      end
    end

    nil
  end

  def row_winner
    @grid.each do |row|
      return row[0] if row.all?{|spot| spot == row[0]}
    end

    nil
  end

  def left_diagonal_win?
    i = 0

    marker = self[0,0]
    @grid.each do |row|
      return false if row[i] != marker
      i += 1
    end

    true
  end

  def right_diagonal_win?
    i = 0
    marker = self[-1,0]

    @grid.reverse.each do |row|
      return false if row[i] != marker
      i += 1
    end

    true
  end

  def print_line
    puts "==================================="
  end
end
