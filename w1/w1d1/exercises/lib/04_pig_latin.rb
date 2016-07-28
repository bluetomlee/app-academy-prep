#started as this simpler version: https://gist.github.com/toddnestor/3139b33afd6de2af71cc4998046966a5

def translate( words )
  words.translate
end

class String
  def grab_punctuation
    punctuation = ''

    if !self[-1].match(/[a-z]/i)
      punctuation = self[-1]
      self.replace( self[0..( self.length - 2)] )
    end

    punctuation
  end

  def is_capitalized?
    self[0].upcase == self[0]
  end

  def capitalize_maybe( capitalize )
    return self.capitalize if capitalize
    self
  end

  def pig_latinize_word
    punctuation = self.grab_punctuation
    started_capitalized = self.is_capitalized?

    parts = self.split(/\b([^a,e,i,o,u]{0,}qu|[^a,e,i,o,u]+)?([a,e,i,o,u][a-z]{0,})?/i) #https://regex101.com/r/yP8yF9/3 <-- this is where I worked out the regex
    parts.shift if parts.first.empty? #getting rid of that first empty element that results from the regex matching the entire word, adding the conditional just in case there are outliers where the first word is not blank that I haven't thought of
    parts << parts.shift #moving the first element to be the last element

    ( "#{parts.join('')}ay".downcase + punctuation ).capitalize_maybe( started_capitalized )
  end

  def translate
    ( self.split(' ').inject([]) {|pig_latinized_words,word| pig_latinized_words << word.pig_latinize_word } ).join(' ') #did it all in one line because I was curious if Ruby would let me, it just splits the words up by spaces, makes a new array of the pig latinized words, and then joins them back with spaces
  end
end
