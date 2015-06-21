
def add num1, num2
  num1 + num2
end

def subtract num1, num2
  num1 - num2
end

def sum numbers
  numbers.inject(0, :+)
end

def multiply *numbers
  numbers.inject(:*)
end

def power number, power
  Array.new(power, number).inject(:*)
end

def factorial number
  (1..number).to_a.inject(1, :*)
end
