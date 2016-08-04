def reverser( &prc )
  ( prc.call.split(' ').map {|word| word.reverse} ).join(' ')
end

def adder( x = 1, &prc )
  prc.call + x
end

def repeater( x = 1 )
  x.times { yield }
end
