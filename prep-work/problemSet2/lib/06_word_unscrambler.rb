# def word_unscrambler(str, words)
#   arr = []
#   sorted = str.chars.sort
#   words.each do |word|
#     arr << word if word.chars.sort == sorted
#   end
#   return arr
# end

# def word_unscrambler(word, arr)
#   return arr.select { |w| w.chars.sort == word.chars.sort }
# end

def word_unscrambler(target, dictionary)
  dictionary.select { |word| word.chars.sort == target.chars.sort }
end
