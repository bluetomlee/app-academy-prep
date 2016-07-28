def ftoc( temp )
  ( ( ( temp - 32 ) / 1.8 ) * 100 ).round / 100.0
end

def ctof( temp )
  ( ( temp * 1.8  + 32 ) * 100 ).round / 100.0
end
