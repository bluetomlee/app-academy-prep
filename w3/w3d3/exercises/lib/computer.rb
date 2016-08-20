class ComputerPlayer
  attr_accessor :name, :board, :attacking_board

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def place_ships
    @board.randomly_place_ships

    puts
    puts "#{@name} placed all of their ships."
    #Helper.press_enter
    puts
  end

  def take_turn
    if @attacking_board.currently_attacking
      pos = fire_on_ship
    else
      pos = Position.random_empty(@attacking_board)
    end

    @attacking_board.attack(pos)
    @attacking_board.display

    puts "#{@name} has finished their turn."
    Helper.press_enter
  end

  def fire_on_ship
    hits = @attacking_board.currently_attacking.hits

    if hits.length == 1
      last_hit = hits[0]
      pos = Position.new(last_hit[0], last_hit[1], @attacking_board)
      return pos.surrounding_positions.sample
    else
      options = {}

      if hits[0][0] == hits[1][0]
        options = {:x_only => true}
      else
        options = {:y_only => true}
      end

      hits.each do |hit|
        pos = Position.new(hit[0], hit[1], @attacking_board)
        return pos.surrounding_positions(options).sample if pos.surrounding_positions(options).length > 0
      end
    end

    Position.random_empty(@attacking_board)
  end

  private
end
