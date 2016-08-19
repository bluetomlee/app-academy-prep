class ComputerPlayer
  attr_accessor :name, :board

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def place_ships
    puts "Computer is placing ships..."
  end
end
