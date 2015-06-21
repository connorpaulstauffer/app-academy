def divisors(n)
  return (1..n).to_a.select { |d| n % d == 0 }
end

def cats_with_hats(cats)
  return (1..cats).to_a.select { |c| divisors(c).length % 2 != 0 }
end

puts cats_with_hats(100)