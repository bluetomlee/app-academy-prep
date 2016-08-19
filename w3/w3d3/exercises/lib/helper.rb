class Helper
  def self.prompt( message )
    puts message
    gets.chomp
  end

  def self.press_enter
    Helper.prompt("Press Enter to proceed.")
  end
end
