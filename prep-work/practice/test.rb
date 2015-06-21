def crazy_sum(numbers)
  sum = 0
  numbers.each_with_index do |n, i|
    sum += n * i
  end
  return sum
end

puts crazy_sum([2]) == 0 
puts crazy_sum([2, 3]) == 3 
puts crazy_sum([2, 3, 5]) == 13 
puts crazy_sum([2, 3, 5, 2]) == 19
  
  
def square_nums(max)
  num = 0
  top = 0
  i = 1
  while top < max
    top = i * i
    num += 1 if top < max
    i += 1
  end
  return num
end

puts square_nums(5) == 2
puts square_nums(10) == 3
puts square_nums(25) == 4


def crazy_nums(max)
  arr = []
  (3).upto(max - 1) do |i|
    arr << i if i < max && (i % 3 == 0 || i % 5 == 0) && !(i % 3 == 0 && i % 5 == 0)
  end
  return arr
end

puts crazy_nums(3) == []
puts crazy_nums(10) == [3, 5, 6, 9]
puts crazy_nums(20) == [3, 5, 6, 9, 10, 12, 18]


def fizzbuzz()
  1.upto(100) do |i|
    str = ""
    str << "Fizz" if i % 3 == 0
    str << "Buzz" if i % 5 == 0
    puts str.empty? ? i : str
  end
end


def MeanMode(arr)
  sum = 0
  arr.each do |e|
    sum += e
  end
  mean = sum.to_f / arr.length
  
  arr.sort!
  if arr.length % 2 == 0
    mode = arr[arr.length / 2].to_f / arr[arr.length / 2 + 1]
  else
    mode = arr[arr.length / 2]
  end
  
  if mean == mode
    return 1
  else
    return 0
  end
end

def PrimeMover(num)
  def is_prime?(n)
    return false if n < 1
    2.upto(n - 1) do |i|
      return false if n % i == 0
    end
    return true
  end
  count = 1
  n = 2
  until count == num
    n += 1
    count += 1 if is_prime?(n)
  end  
  return n        
end


def PalindromeTwo(str)
  alph = "abcdefghijklmnopqrstuvwxyz"
  valid = []
  str.each_char do |c|
    valid << c if alph.chars.include?(c)
  end
  0.upto(valid.length / 2 - 1) do |i|
    return false if valid[i] != valid[valid.length - 1 - i]
  end
  return true
end


def StringScramble(str1,str2)

  return str1.downcase.chars.sort == str2.downcase.chars.sort 
         
end


def LetterCount(str)
  words = str.split(' ')
  maxrepeats = 1
  max = -1
  words.each do |word|
    word.chars.uniq.each do |char|
      without = word.chars.select { |c| c != char }
      difference = word.length - without.length
      if difference > maxrepeats
        max = word
        maxrepeats = difference
      end
    end
  end
  return max
end


def CaesarCipher(str,num)
  def shift_letter(c, n)
    upcase = (c.upcase == c) ? true : false
    alph = "abcdefghijklmnopqrstuvwxyz"
    idx = alph.index(c.downcase)
    idx = (idx + n) % 26
    return upcase ? alph[idx].upcase : alph[idx]
  end
  shift = str.chars.map do |char|
            alph = "abcdefghijklmnopqrstuvwxyz"
            if alph.include?(char.downcase)
              shift_letter(char, num)
            else
              char
            end
          end
  return shift.join('')
end


def FormattedDivision(num1,num2)
  val = num1 / num2.to_f
  val = val.to_s.split('.')
  if val[1].length < 4
    (4 - val[1].length).times do
      val[1] << '0'
    end
  elsif val[1].length > 4
    val[1][3] = (val[1][3].to_i + 1).to_s if val[1][3].to_i > 4
    val[1] = val[1].slice(0, 4)
  end
  left = val[0].length
  commas = 0
  while left > 3
    val[0].insert(-4 * (1 + commas), ',')
    left -= 3
    commas += 1
  end
  return val.join('.')
end

def without_punctuation(word)
  new = word.chars.select { |c| !(',.'.include?(c)) }
  return new.join('')
end

def only_words(str)
  words = str.split(' ')
  new = words.map { |w| without_punctuation(w) }
  return new.join(' ')
end