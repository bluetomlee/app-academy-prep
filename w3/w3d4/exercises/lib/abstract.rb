class Abstract
  def prompt( message )
    puts message
    gets.chomp
  end

  def press_enter
    Helper.prompt("Press Enter to proceed.")
  end
end
