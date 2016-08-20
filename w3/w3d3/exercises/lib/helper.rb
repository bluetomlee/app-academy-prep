class Helper
  def self.prompt( message )
    puts message
    gets.chomp
  end

  def self.press_enter
    Helper.prompt("Press Enter to proceed.")
  end

  def self.range(start, stop)
    small = [start, stop].min
    large = [start, stop].max
    (small..large)
  end
end
