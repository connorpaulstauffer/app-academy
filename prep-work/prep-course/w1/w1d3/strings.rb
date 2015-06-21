
# In this exercise, you will define a method num_to_s(num, base), which will
# return a string representing the original number in a different base
# (up to base 16).
def num_to_s num, base
  return "0" if num == 0
  hex_mapping = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b",
                  "c", "d", "e", "f" ]
  str = ""
  i = 0
  while (num / (base ** i)) > 0
    str << hex_mapping[(num / (base ** i)) % base]
    i += 1
  end
  str.reverse
end

# Implement a Caesar cipher. Example: caesar("hello", 3) # => "khoor"
def caesar string, shift
  string.downcase.chars.map do |char|
    val = (char.ord + (shift % 26)) % 123
    val > 96 ? val.chr : (val + 97).chr
  end.join("")
end
