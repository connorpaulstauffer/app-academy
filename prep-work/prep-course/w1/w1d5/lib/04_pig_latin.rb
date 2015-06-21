
def translate string
  string.split(' ').map { |word| translate_word(word) }.join(' ')
end

def translate_word word
  word << ( word.slice!(/^([^aeiou]*qu?|[^aeiou]+)/) || "" )
  word << "ay"
end
