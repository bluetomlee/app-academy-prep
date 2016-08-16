#I used class Integer instead since then both Fixnum and Bignum can draw on it
class Integer
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

      number_words.unshift( ( current_value / divisor ).in_words + ' ' + WORDS['large_nums'][ divisor.to_f ] ) if current_value > 0

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
      1e3 => 'thousand',
      1e6 => 'million',
      1e9 => 'billion',
      1e12 => 'trillion',
      1e15 => 'quadrillion',
      1e18 => 'quintillion',
      1e21 => 'sextillion',
      1e24 => 'septillion',
      1e27 => 'octillion',
      1e30 => 'nonillion',
      1e33 => 'decillion',
      1e36 => 'undecillion',
      1e39 => 'duodecillion',
      1e42 => 'tredecillion',
    }
  }
end
