require 'byebug'

class HumanPlayer
  attr_accessor :name, :board, :attacking_board

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def place_ships
    if Helper.prompt("Enter R to automatically randomly place your ships, \nor just press enter to place your ships manually.") == "R"
      @board.ships.each do |ship|
        start = random_start_pos(ship)
        ship.place(start, random_end_pos(start, ship))
      end
    else
      @board.ships.each do |ship|
        puts "You are placing your #{ship.name}. It is #{ship.length} boxes long."
        start = start_pos(ship)
        ship.place(start, end_pos(start, ship))
      end
    end

    puts
    puts "You have placed all of your ships."
    @board.display(false, false)
    Helper.press_enter
    puts
  end

  def take_turn
    pos = nil
    puts
    puts "#{@name}, it's your turn!"
    puts

    until pos && pos.valid? && pos.empty?
      @attacking_board.display
      input = Helper.prompt("Enter the position you want to fire at!")
      pos = parse_position( input, @attacking_board )
    end

    @attacking_board.attack(pos)
    @attacking_board.display

    puts "Your turn is over."
    Helper.press_enter
  end

  private
  def start_pos(ship)
    pos = nil

    until pos && pos.valid? && ship.available_end_positions(pos).length > 0
      @board.display(false, false)
      input = Helper.prompt("Enter the start position for where the ship will be placed.")
      pos = parse_position( input )

      unless pos && pos.valid? && pos.empty? && ship.available_end_positions(pos).length > 0
        puts "You entered an invalid position. Please try again."
        puts "All end positions for that start position are blocked." if pos && ship.available_end_positions(pos).length == 0
        pos = nil
      end
    end

    pos
  end

  def parse_position(input, board = @board)
    input_col = input.slice(0)
    input_row = input.slice(1,2).to_i - 1

    if input_col && input_row
      input_col = input_col.upcase.ord - 65
      return Position.new(input_row, input_col, board)
    end

    nil
  end

  def end_pos(start, ship)
    end_position = nil

    until end_position && ship.available_end_positions(start).any? {|pos| pos == end_position}
      @board.print_possible_positions(start, ship.available_end_positions(start), false)

      input = Helper.prompt("Enter the end position for where the ship will be placed.")
      end_position = parse_position( input )

      unless end_position && ship.available_end_positions(start).any? {|pos| pos == end_position}
        end_position = nil
        puts "You entered an invalid option. Please try again."
      end
    end

    end_position
  end

  def random_start_pos(ship)
    pos = nil

    until pos && pos.valid? && ship.available_end_positions(pos).length > 0
      pos = Position.random_empty(@board)
    end

    pos
  end

  def random_end_pos(start, ship)
    ship.available_end_positions(start).sample
  end
end
