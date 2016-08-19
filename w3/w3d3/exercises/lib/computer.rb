class ComputerPlayer
  attr_accessor :name, :board

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def place_ships
    @board.ships.each do |ship|
      start = start_pos(ship)
      ship.place(start, end_pos(start, ship))
    end

    puts
    puts "#{@name} placed all of their ships."
    #Helper.press_enter
    puts
  end

  def take_turn(board)
    if board.currently_attacking
      pos = fire_on_ship(board)
    else
      pos = Position.random_empty(board)
    end

    board.attack(pos)
    board.display

    puts "#{@name} has finished their turn."
    Helper.press_enter
  end

  def fire_on_ship(board)
    hits = board.currently_attacking.hits

    if hits.length == 1
      last_hit = hits[0]
      pos = Position.new(last_hit[0], last_hit[1])
      return pos.surrounding_positions(board).sample
    else
      options = {}

      if hits[0][0] == hits[1][0]
        options = {:x_only => true}
      else
        options = {:y_only => true}
      end

      hits.each do |hit|
        pos = Position.new(hit[0], hit[1])
        return pos.surrounding_positions(board, options).sample if pos.surrounding_positions(board, options).length > 0
      end
    end

    Position.random_empty(board)
  end

  private
  def start_pos(ship)
    pos = nil

    until pos && pos.valid?(@board) && ship.available_end_positions(pos, @board).length > 0
      pos = Position.random_empty(@board)
    end

    pos
  end

  def end_pos(start, ship)
    ship.available_end_positions(start, @board).sample
  end
end
