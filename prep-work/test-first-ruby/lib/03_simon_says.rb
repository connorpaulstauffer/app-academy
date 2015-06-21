def echo message
  message
end

def shout message
  message.upcase
end

def repeat message, num = 2
  ("#{message} " * num).chop
end

def start_of_word string, num
  string[0..(num - 1)]
end

def first_word string
  string.split[0]
end

def titleize string
  little_words = ["and", "the", "is", "a", "over"]
  string.split.map.with_index do |word, idx| 
    if idx == 0 || !little_words.include?(word)
      word.capitalize
    else
      word
    end
  end.join(" ")
end
