def add( x, y )
  x + y
end

def subtract( x, y )
  x - y
end

def sum( nums )
  nums.inject(0) { |total,num| total += num }
end

def multiply( *nums )
  nums.inject(:*)
end

def power( x, y )
  x ** y
end

def factorial( n )
  (1..n).inject(:*) || 1
end
