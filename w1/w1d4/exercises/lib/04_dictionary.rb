class Dictionary
  attr_accessor :entries

  def initialize
    @entries = {}
  end

  def add( entry )
    @entries = @entries.merge( entry.is_a?(Hash) ? entry : {entry => nil} )
  end

  def keywords
    @entries.keys.sort
  end

  def include?( key )
    @entries.has_key?( key )
  end

  def find( keyword )
    @entries.select{ |key, value| key.match( keyword )}
  end

  def printable
    keywords.inject(''){ |final, keyword| final + (final.empty? ? '' : "\n") + "[#{keyword}] \"#{@entries[ keyword ]}\""}
  end
end
