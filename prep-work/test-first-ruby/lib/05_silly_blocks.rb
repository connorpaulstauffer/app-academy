def reverser
  yield.split.map { |word| word.reverse }.join(" ")
end

def adder add = 1
  yield + add
end

def repeater rep = 1
  rep.times { yield }
end