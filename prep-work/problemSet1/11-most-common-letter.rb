# Write a method that takes in a string. Your method should return the
# most common letter in the array, and a count of how many times it
# appears.
#
# Difficulty: medium.

def most_common_letter(string)
  unique = string.chars.uniq
  maxChar = string[0]
  maxCount = string.chars.count maxChar
  unique.each do |char|
    count = string.count char
    if count > maxCount
      maxCount = count
      maxChar = char
    end
  end
  
  return [maxChar, maxCount]  
end

# These are tests to check that your code is working. After writing
# your solution, they should all print true.

puts(
  'most_common_letter("abca") == ["a", 2]: ' +
  (most_common_letter('abca') == ['a', 2]).to_s
)
puts(
  'most_common_letter("abbab") == ["b", 3]: ' +
  (most_common_letter('abbab') == ['b', 3]).to_s
)
