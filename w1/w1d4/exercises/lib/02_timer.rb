class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def leading_zero( num )
    "#{num < 10 ? '0' : ''}#{num}"
  end

  def hours
    seconds / 3600 #no need for integer conversion because of how ruby does math
  end

  def minutes
    ( seconds % 3600 ) / 60 #no need for integer conversion because of how ruby does math
  end

  def remaining_seconds
    seconds % 60 #no need for integer conversion because of how ruby does math
  end

  def time_string
    "#{leading_zero(hours)}:#{leading_zero(minutes)}:#{leading_zero(remaining_seconds)}"
  end
end
