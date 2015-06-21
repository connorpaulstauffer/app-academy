
def echo message
  message
end

def shout message
  message.upcase
end

def repeat message, times = 2
  Array.new(times, message).join(" ")
end

def start_of_word word, letters
  word.slice(0, letters)
end

def first_word string
  string.split(" ")[0]
end

def titleize string
  little_words = ["and", "the", "over"]
  string.split(' ').map.with_index do |word, i|
    (i == 0 || !little_words.include?(word)) ? word.capitalize : word
  end.join(' ')
end
