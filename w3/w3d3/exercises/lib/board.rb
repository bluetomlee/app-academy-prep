class Board
  attr_accessor :grid, :ships

  def initialize(grid=nil, ships = default_ships)
    @grid = grid || Array.new(10) { Array.new(10) }
    @ships = ships
    @currently_attacking = nil
  end

  def [](row, col)
    @grid[row][col] if @grid[row]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def print_possible_positions(start_position, end_positions, attacker=true)
    place_mark(start_position.coordinates, 'N')
    end_positions.each do |position|
      p position
      place_mark(position.coordinates, 'E')
    end

    puts "N marks the start point for the ship you are currently placing."
    puts "E marks the possible endpoints."
    display(attacker)
    unmark(start_position.coordinates)
    end_positions.each {|position| unmark(position.coordinates)}
  end

  def display(attacker = true)
    puts "#{column_headers}\n   #{grid_line}\n#{rows(attacker)}"
    puts "   #{grid_line}"
  end

  def attack(pos)
     if has_ship?(pos.coordinates)
       hit(pos.coordinates)
     else
       miss(pos.coordinates)
     end
  end

  def has_ship?(pos)
    @ships.each do |ship|
      return true if ship.hit?(pos)
    end

    false
  end

  def empty?(pos)
    self[*pos].nil?
  end

  def place_mark(pos, mark)
    self[*pos] = mark if empty?(pos) && valid_position?(pos)
  end

  def unmark(pos)
    self[*pos] = nil
  end

  def won?
    @ships.all? {|ship| ship.sunk?}
  end

  def height
    @grid.length
  end

  def width
    @grid[0].length
  end

  def valid_position?(pos)
    width = @grid[0].length - 1
    height = @grid.length - 1
    (0..width).include?(pos[0]) && (0..height).include?(pos[1])
  end

  private
  def hit(pos)
    place_mark(pos, hit_marker)
    @currently_attacking = @ships.select {|ship| ship.hit?(pos)}.first

    puts "You hit my #{@currently_attacking.name}!"
    @currently_attacking.hit(pos)

    if @currently_attacking.sunk?
      puts "You sunk my #{@currently_attacking.name}!"
      attacking_no_one
    end
  end

  def attacking_no_one
    @currently_attacking = nil
  end

  def miss(pos)
    place_mark(pos, miss_marker)
    puts "You missed!"
  end

  def column_headers
    @grid.each_with_index.inject("     ") do |headers, (item, index)|
      headers << "#{("A".ord + index).chr}   "
    end
  end

  def grid_line
    "-" * (4.1 * @grid.length).ceil
  end

  def rows(attacker = true)
    display_rows = []

    @grid.each_with_index do |row, index|
      display_items = []

      row.each_with_index do |item, index2|
        pos = [index,index2]

        if !item
          if has_ship?(pos) && !attacker
            display_items << "S"
          else
            display_items << " "
          end
        else
          display_items << item
        end
      end

      display_rows << "#{index + 1}#{index + 1 > 9 ? "":" "} | #{display_items.join(' | ')} |"
    end

    display_rows.join("\n   #{grid_line}\n")
  end

  def default_ships
    [
      Ship.new('Aircraft carrier', 5),
      Ship.new('Battleship', 4),
      Ship.new('Submarine', 3),
      Ship.new('Cruiser', 3),
      Ship.new('Patrol boat', 2)
    ]
  end

  def ship_marker
    "S"
  end

  def hit_marker
    "X"
  end

  def miss_marker
    "O"
  end
end
