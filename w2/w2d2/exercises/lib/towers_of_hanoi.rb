# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
  attr_accessor :towers

  def initialize
    @towers = [[3,2,1],[],[]]
  end

  def play
    until won?
      render
      from = get_input("Where do you want to move from?")
      to = get_input("Where do you want to move to?")

      if valid_move?( from, to )
        move( from, to )
      else
        puts "You can only move a disk onto an empty tower or onto a disk that is larger than it, please try again."
      end
    end

    render
    puts "You won!"
  end

  def render
    puts "======================================="
    puts "\t Towers \t"
    puts "A\tB\tC"
    (0..2).to_a.reverse.each do |num|
      puts "#{disk_at(0, num)}\t#{disk_at(1, num)}\t#{disk_at(2, num)}"
    end
    puts "======================================="
  end

  def move( from, to )
    @towers[to] << @towers[from].pop
  end

  def valid_move?( from, to )
    return true if has_stuff?( from ) && piece_smaller_than?( from, to )
    false
  end

  def won?
    first_tower_empty? && only_one_tower_has_pieces?
  end

  private
  TOWERS = {"A" => 0, "B" => 1, "C" => 2}

  def tower_from_input( input )
    TOWERS[ input ]
  end

  def has_stuff?( tower )
    !@towers[ tower ].empty?
  end

  def piece( tower )
    @towers[ tower ].last
  end

  def piece_smaller_than?( from, to )
    !piece( to ) || piece( from ) < piece( to )
  end

  def first_tower_empty?
    @towers.first.empty?
  end

  def only_one_tower_has_pieces?
    @towers.one? { |tower| !tower.empty? }
  end

  def get_input( message )
    while true
      tower = tower_from_input( prompt( message ) )
      return tower if tower
      puts "That is not a valid tower...please try again."
    end
  end

  def prompt( message )
    puts message
    gets.chomp.upcase
  end

  def disk_at( tower, level )
    if @towers[ tower ][ level ]
      @towers[ tower ][ level ]
    else
      " "
    end
  end
end
