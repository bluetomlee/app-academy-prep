class Friend
  def greeting(name = '')
    "Hello#{name.empty? ? '' : ', ' + name}!"
  end
end
