# 501
def divisors(n)
  return (1..n).to_a.select { |d| n % d == 0 }
end

def eight_divisors(x)
  return (1..x).to_a.select { |i| divisors(i).length == 8 }
end

# puts "501: " + eight_divisors(10 ** 12).length.to_s


# 1
def sum_multiples(n)
  sum = 0
  3.upto(n - 1) { |i| sum += i if i % 3 == 0 || i % 5 == 0 }
  return sum
end

#puts "1: " + sum_multiples(1000).to_s


# 2
def even_fibs(n)
  sum = 0
  i = 1
  j = 2
  while j <= n
    sum += j if j % 2 == 0
    i, j = j, i + j
  end
  return sum
end

#puts "2: " + even_fibs(4000000).to_s


# 3
def is_prime?(n)
  return false if n < 2
  2.upto((n / 2) - 1) { |i| return false if n % i == 0 }
  return true
end

def largest_prime(n)
  return n if is_prime?(n)
  2.upto((n / 2) - 1) do |d|
    value = n / d.to_f
    return value.to_i if value % 1 == 0 && is_prime?(value)
  end
  return nil
end

#puts "3: " + largest_prime(600851475143).to_s


# 4
def is_palindrome?(n)
  n = n.to_s.chars
  0.upto(n.length / 2) do |i|
    return false if n[i] != n[n.length - 1 - i]
  end
  return true
end

def largest_palindrome()
  products = []
  100.upto(999) do |i|
    100.upto(999) do |j|
      products << i * j
    end
  end
  products.sort!
  (products.length - 1).downto(0) do |n|
    return products[n] if is_palindrome?(products[n])
  end
end

#puts largest_palindrome()
  

# 5
def is_divisible?(n, s, f)
  s.upto(f) { |i| return false if n % i.to_f != 0 }
  return true
end

def smallest_divisible(s, f)
  n = f * (f - 1)
  while true
    return n if is_divisible?(n, s, f)
    n += f * (f - 1)
  end
end

puts smallest_divisible(1, 20)