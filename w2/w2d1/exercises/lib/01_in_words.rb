class Fixnum
  def in_words
    num = self
    number_words = []

    last_two_digits = num % 100

    num -= last_two_digits

    if( last_two_digits < 20 )
      number_words << less_than_twenty( last_two_digits ) if last_two_digits > 0 || num == 0
    else
      ones = last_two_digits % 10
      tens_value = last_two_digits - ones
      number_words << tens( tens_value )
      number_words << less_than_twenty( ones ) if ones > 0
    end

    if( num > 0 )
      hundreds_value = num % 1000
      num -= hundreds_value
      number_words.unshift( less_than_twenty( hundreds_value / 100 ) + ' hundred' ) if hundreds_value > 0
    end

    if( num > 0 )
      thousands_value = num % 1000000
      num -= thousands_value
      number_words.unshift( ( thousands_value / 1000 ).in_words + ' thousand' ) if thousands_value > 0
    end

    if( num > 0 )
      millions_value = num % 1000000000
      num -= millions_value
      number_words.unshift( ( millions_value / 1000000 ).in_words + ' million' ) if millions_value > 0
    end

    if( num > 0 )
      billions_value = num % 1000000000000
      num -= billions_value
      number_words.unshift( ( billions_value / 1000000000 ).in_words + ' billion' ) if billions_value > 0
    end

    if( num > 0 )
      trillions_value = num % 1000000000000000
      num -= trillions_value
      number_words.unshift( ( trillions_value / 1000000000000 ).in_words + ' trillion' ) if trillions_value > 0
    end

    number_words.join(' ')
  end

  def less_than_twenty(num)
    WORDS["to_nineteen"][num]
  end

  def tens(num)
    WORDS["tens"][ ( num / 10 ) - 2 ]
  end

  WORDS = {
    "to_nineteen" => %w(
      zero one two three four five six seven eight nine ten eleven twelve
      thirteen fourteen fifteen sixteen seventeen eighteen nineteen
      ),
    "tens" => %w(
      twenty thirty forty fifty sixty seventy eighty ninety
    )
  }
end

class Bignum
  def in_words
    num = self
    number_words = []

    last_two_digits = num % 100

    num -= last_two_digits

    if( last_two_digits < 20 )
      number_words << less_than_twenty( last_two_digits ) if last_two_digits > 0 || num == 0
    else
      ones = last_two_digits % 10
      tens_value = last_two_digits - ones
      number_words << tens( tens_value )
      number_words << less_than_twenty( ones ) if ones > 0
    end

    if( num > 0 )
      hundreds_value = num % 1000
      num -= hundreds_value
      number_words.unshift( less_than_twenty( hundreds_value / 100 ) + ' hundred' ) if hundreds_value > 0
    end

    if( num > 0 )
      thousands_value = num % 1000000
      num -= thousands_value
      number_words.unshift( ( thousands_value / 1000 ).in_words + ' thousand' ) if thousands_value > 0
    end

    if( num > 0 )
      millions_value = num % 1000000000
      num -= millions_value
      number_words.unshift( ( millions_value / 1000000 ).in_words + ' million' ) if millions_value > 0
    end

    if( num > 0 )
      billions_value = num % 1000000000000
      num -= billions_value
      number_words.unshift( ( billions_value / 1000000000 ).in_words + ' billion' ) if billions_value > 0
    end

    if( num > 0 )
      trillions_value = num % 1000000000000000
      num -= trillions_value
      number_words.unshift( ( trillions_value / 1000000000000 ).in_words + ' trillion' ) if trillions_value > 0
    end

    number_words.join(' ')
  end

  def less_than_twenty(num)
    WORDS["to_nineteen"][num]
  end

  def tens(num)
    WORDS["tens"][ ( num / 10 ) - 2 ]
  end

  WORDS = {
    "to_nineteen" => %w(
      zero one two three four five six seven eight nine ten eleven twelve
      thirteen fourteen fifteen sixteen seventeen eighteen nineteen
      ),
    "tens" => %w(
      twenty thirty forty fifty sixty seventy eighty ninety
    )
  }
end
