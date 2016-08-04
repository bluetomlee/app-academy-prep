class Temperature
  def initialize( options )
    if options[:f]
      @fahrenheit = options[:f]
    elsif options[:c]
      @celsius = options[:c]
    end
  end

  def self.from_celsius( temp )
    self.new( c: temp )
  end

  def self.from_fahrenheit( temp )
    self.new( f: temp )
  end

  def c_to_f( temp )
    temp * 9 / 5.0 + 32
  end

  def f_to_c( temp )
    ( temp - 32 ) * 5.0 / 9
  end

  def in_fahrenheit
    @fahrenheit ? @fahrenheit : c_to_f( @celsius )
  end

  def in_celsius
    @celsius ? @celsius : f_to_c( @fahrenheit )
  end
end

class Celsius < Temperature
  def initialize(temp)
    @celsius = temp
  end
end

class Fahrenheit < Temperature
  def initialize(temp)
    @fahrenheit = temp
  end
end
