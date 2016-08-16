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

    divisor = 1000

    until num == 0
      current_value = num % ( divisor * 1000 )
      num -= current_value

      number_words.unshift( ( current_value / divisor ).in_words + ' ' + WORDS['large_nums'][ divisor ] ) if current_value > 0

      divisor *= 1000
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
      ),
    "large_nums" => {
      1000 => 'thousand',
      1000000 => 'million',
      1000000000 => 'billion',
      1000000000000 => 'trillion'
    }
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

    divisor = 1000

    until num == 0
      current_value = num % ( divisor * 1000 )
      num -= current_value

      number_words.unshift( ( current_value / divisor ).in_words + ' ' + WORDS['large_nums'][ divisor ] ) if current_value > 0

      divisor *= 1000
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
      ),
    "large_nums" => {
      1000 => 'thousand',
      1000000 => 'million',
      1000000000 => 'billion',
      1000000000000 => 'trillion'
    }
  }
end
