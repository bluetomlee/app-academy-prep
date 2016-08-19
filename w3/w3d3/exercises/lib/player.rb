require 'byebug'

class HumanPlayer
  attr_accessor :name, :board

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def place_ships
    @board.ships.each do |ship|
      puts "You are placing your #{ship.name}. It is #{ship.length} boxes long."
      start = start_pos(ship)
      ship.place(start, end_pos(start, ship))
    end

    puts
    puts "You have placed all of your ships."
    Helper.press_enter
    puts
  end

  def take_turn(board)
    pos = nil
    puts
    puts "#{@name}, it's your turn!"
    puts

    until pos && pos.valid?(board) && board.empty?(pos.coordinates)
      board.display
      input = Helper.prompt("Enter the position you want to fire at!")
      pos = Position.parse( input )
    end

    board.attack(pos)
    board.display

    puts "Your turn is over."
    Helper.press_enter
  end

  private
  def start_pos(ship)
    pos = nil

    until pos && pos.valid?(@board) && ship.available_end_positions(pos, @board).length > 0
      @board.display(false)
      input = Helper.prompt("Enter the start position for where the ship will be placed.")
      pos = Position.parse( input )

      unless pos && pos.valid?(@board) && @board.empty?(pos.coordinates) && ship.available_end_positions(pos, @board).length > 0
        puts "You entered an invalid position. Please try again."
        puts "All end positions for that start position are blocked." if pos && ship.available_end_positions(pos, @board).length == 0
        pos = nil
      end
    end

    pos
  end

  def end_pos(start, ship)
    end_position = nil

    until end_position && ship.available_end_positions(start, @board).any? {|pos| pos.coordinates == end_position.coordinates}
      @board.print_possible_positions(start, ship.available_end_positions(start, @board), false)

      input = Helper.prompt("Enter the end position for where the ship will be placed.")
      end_position = Position.parse( input )

      unless end_position && ship.available_end_positions(start, @board).any? {|pos| pos == end_position}
        end_position = nil
        puts "You entered an invalid option. Please try again."
      end
    end

    end_position
  end
end
