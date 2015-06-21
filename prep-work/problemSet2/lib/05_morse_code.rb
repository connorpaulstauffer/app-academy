MORSE_CODE = {
  "a" => ".-",
  "b" => "-...",
  "c" => "-.-.",
  "d" => "-..",
  "e" => ".",
  "f" => "..-.",
  "g" => "--.",
  "h" => "....",
  "i" => "..",
  "j" => ".---",
  "k" => "-.-",
  "l" => ".-..",
  "m" => "--",
  "n" => "-.",
  "o" => "---",
  "p" => ".--.",
  "q" => "--.-",
  "r" => ".-.",
  "s" => "...",
  "t" => "-",
  "u" => "..-",
  "v" => "...-",
  "w" => ".--",
  "x" => "-..-",
  "y" => "-.--",
  "z" => "--.."
}

# def morse_encode(str)
#   words = str.split(' ')
#   morse = words.map { |w| morse_encode_word(w) }
#   return morse.join('  ')
# end
#
# def morse_encode_word(word)
#   chars = word.chars
#   morse = chars.map { |c| MORSE_CODE[c] }
#   return morse.join(' ')
# end

def morse_encode(words)
  words.split(" ").map { |word| morse_encode_word(word) }.join("  ")
end

def morse_encode_word(word)
  word.chars.map { |char| MORSE_CODE[char] }.join(" ")
end
