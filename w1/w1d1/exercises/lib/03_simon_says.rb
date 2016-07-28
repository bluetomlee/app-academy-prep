def echo( stuff )
  stuff
end

def shout( stuff )
  stuff.upcase
end

def repeat( stuff, num = 2 )
  ( ( stuff + " " ) * num ).strip
end

def start_of_word( words, num )
  words[0..(num - 1)]
end

def first_word( words )
  words.split(' ').first
end

def capitalizes( word )
  letters = word.split('')

  letters[0] = letters[0].upcase

  letters.join('')
end

NON_CAPITALIZE_WORDS = [
  'a',
  'an',
  'the',
  'at',
  'by',
  'for',
  'in',
  'of',
  'on',
  'to',
  'up',
  'and',
  'as',
  'but',
  'or',
  'nor',
  'over'
]

def titleize( words )
  incrementer = 0

  words.split(' ').inject('') do |titleized, word|
    incrementer += 1
    if incrementer > 1 && NON_CAPITALIZE_WORDS.include?( word )
      titleized += ' ' + word
    else
      ( titleized += ' ' + capitalizes( word ) ).strip
    end
  end
end
