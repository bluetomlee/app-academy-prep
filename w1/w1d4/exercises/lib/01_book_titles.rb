require 'byebug'

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
    'is',
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
    @title = title.split(' ').inject('') do |final_title, word|
      final_title += ' ' unless final_title.empty?

      if should_be_capitalized?( final_title, word )
        final_title += word.capitalize
      else
        final_title += word
      end

      final_title
    end
  end

  private
  def should_be_capitalized?(title, word)
    !is_little_word?( word ) || title.empty?
  end

  def is_little_word?(word)
    LITTLE_WORDS.include?( word )
  end
end
