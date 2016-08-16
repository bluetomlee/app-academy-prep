class RPNCalculator
  def initialize
    @numbers = []
  end

  def push(number)
    @numbers << number
  end

  def plus
    raise_exception_if_no_values
    @numbers << next_number + next_number
  end

  def minus
    raise_exception_if_no_values
    @numbers << -next_number + next_number
  end

  def divide
    raise_exception_if_no_values
    @numbers << 1.0 / next_number * next_number
  end

  def times
    raise_exception_if_no_values
    @numbers << next_number * next_number
  end

  def value
    @numbers.last
  end

  def *
    times
  end

  def +
    plus
  end

  def -
    minus
  end

  def /
    divide
  end

  def tokens(str)
    str.split(' ').map { |item| item.is_numeric? ? item.to_i : item.to_sym }
  end

  def evaluate(str)
    @numbers = []
    tokens(str).each do |item|
      push( item ) if item.is_a?(Integer)
      public_send( item ) unless item.is_a?(Integer)
    end

    value
  end

  private
  def next_number
    @numbers.pop
  end

  def raise_exception_if_no_values
    raise 'calculator is empty' if @numbers.empty?
  end
end

class String
  def is_numeric?
    self.match(/^[0-9\.]+$/)
  end
end
