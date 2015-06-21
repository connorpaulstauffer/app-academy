def add num1, num2
  num1 + num2
end

def subtract num1, num2
  num1 - num2
end

def sum arr
  arr.inject(0, :+)
end

def multiply *numbers
  numbers.inject(1, :*)
end

def power num, pow
  ans = 1
  pow.times { ans *= num }
  ans
end

def factorial num
  ans = 1
  2.upto(num) { |i| ans *= i } if num > 1
  ans
end
