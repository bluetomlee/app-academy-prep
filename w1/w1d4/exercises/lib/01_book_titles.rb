class Book
  attr_reader :title

  LITTLE_WORDS = [
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

  def title=(title)
    @title = title.split(' ').inject('') {|final_title, word| ( final_title + ' ' + ( LITTLE_WORDS.include?(word) && !final_title.empty? ? word : word.capitalize ) ).strip }
  end
end
