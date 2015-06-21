# def ordered_vowel_words(str)
#     words = str.split
#     ordered = []
#     words.each do |word|
#       ordered << word if ordered_vowel_word?(word)
#     end
#     return ordered.join(' ')
# end

# def ordered_vowel_word?(word)
#   vowels = 'aeiou'.chars
#   arr = []
#   word.chars.each do |char|
#     arr << char if vowels.include?(char)
#   end
#   return arr.sort == arr
# end

# def ordered_vowel_words(str)
#   words = str.split(' ')
#   ordered = words.select { |w| ordered_vowel_word?(w) }
#   return ordered.join(' ')
# end
#
# def ordered_vowel_word?(word)
#   vowels = "aeiou"
#   chars = word.chars.select { |c| vowels.include?(c) }
#   return chars.sort == chars
# end

def ordered_vowel_words(words)
  words.split(" ").select { |word| ordered_vowel_word?(word) }.join(" ")
end

def ordered_vowel_word?(word)
  vowels = "aeiou"
  just_vowels = word.chars.select { |char| vowels.include?(char) }
  just_vowels == just_vowels.sort
end
