def translate string
  string.split.map { |word| pig_latin_word(word) }.join(" ")
end

def pig_latin_word word
  vowels = "aeiou"
  consonant_sound = ""
  while !vowels.include?(word[0]) || (consonant_sound[-1] == "q" && word[0] == "u")
      consonant_sound << word.slice!(0)
  end
  "#{word}#{consonant_sound}ay"
end
