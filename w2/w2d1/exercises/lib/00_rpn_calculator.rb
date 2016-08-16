class RPNCalculator
  attr_accessor :value, :numbers

  def initialize
    @numbers = []
  end

  def push(number)
    @numbers << number
  end

  def plus
    do_initial_stuff
    @value += next_number
  end

  def minus
    do_initial_stuff
    @value -= next_number
  end

  def divide
    do_initial_stuff
    @value /= next_number.to_f
  end

  def times
    do_initial_stuff
    @value *= next_number
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
    @value = nil
    @numbers = []
    tokens(str).each do |item|
      push( item ) if item.is_a?(Integer)
      public_send( item ) unless item.is_a?(Integer)
      p @numbers
    end

    @value
  end

  private
  def do_initial_stuff
    set_value_if_not_set
    raise_exception_if_no_values
  end

  def next_number
    @numbers.pop
  end

  def pop_second_from_last
    second_from_last = @numbers[ second_from_last_index ]
    @numbers.delete_at second_from_last_index
    second_from_last
  end

  def second_from_last_index
    @numbers.length - 2
  end

  def set_value_if_not_set
      @value = pop_second_from_last unless @value
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
