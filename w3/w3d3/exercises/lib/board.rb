class Board
  attr_accessor :grid, :ships, :currently_attacking

  def initialize(grid=nil, ships = default_ships)
    @grid = grid || Board.default_grid
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
    end_positions.each_with_index do |position,index|
      place_mark(position.coordinates, index + 1)
    end

    puts "N marks the start point for the ship you are currently placing."
    puts "The possible endpoints are noted by numbers."
    display(attacker, false)
    unmark(start_position.coordinates)
    end_positions.each {|position| unmark(position.coordinates)}
  end

  def display(attacker = true, show_stats = true)
    puts "#{column_headers}\n   #{grid_line}\n#{rows(attacker)}"
    puts "   #{grid_line}"

    if show_stats
      puts
      stats
    end
  end

  def count
    @ships.inject(0) do |total, ship|
      total += 1 if ship.placed?
      total
    end
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

  def empty_positions
    positions = []

    @grid.each_with_index do |row, index|
      row.each_with_index do |spot, index2|
        positions << Position.new(index, index2, self) if spot.nil?
      end
    end

    positions
  end

  def stats
    puts "You have sunk #{ships_sunk} ships, and have #{ships_remaining} left to sink."
    puts "You have hit #{hits} squares."
    puts "You have fired at and missed #{misses} squares."
    puts "And you have #{unknown_spots} left unknown."
  end

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def randomly_place_ships
    @ships.each do |ship|
      ship.randomly_place(self)
    end
  end

  private
  def hit(pos)
    place_mark(pos, hit_marker)
    @currently_attacking = @ships.select {|ship| ship.hit?(pos)}.first

    puts "You hit my #{@currently_attacking.name}!"
    @currently_attacking.hit(pos)

    if @currently_attacking.sunk?
      puts "You sunk my #{@currently_attacking.name}!"
      attacking_next
    end
  end

  def unknown_spots
    ( height * width ) - misses - hits
  end

  def misses
    count_where(miss_marker)
  end

  def hits
    count_where(hit_marker)
  end

  def ships_sunk
    @ships.inject(0) do |total, ship|
      total += 1 if ship.sunk?
      total
    end
  end

  def ships_remaining
    @ships.inject(0) do |total, ship|
      total += 1 unless ship.sunk?
      total
    end
  end

  def count_where(marker)
    @grid.inject(0) do |total, row|
      row.inject(total) do |row_total, spot|
        row_total += 1 if spot == marker
        row_total
      end
    end
  end

  def total_spots
    unknown_spots + misses + hits
  end

  def attacking_next
    @ships.select do |ship|
      ship.hits.length > 0 && !ship.sunk?
    end.first
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
    "-"
  end
end
