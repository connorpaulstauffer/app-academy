# def letter_count(str)
#   counts = Hash.new(0)
#   str = str.chars
#   str.uniq.each do |char|
#     counts[char] = str.count(char) unless char == " "
#   end
#   return counts
# end

# def letter_count(str)
#   counts = Hash.new(0)
#   str.each_char { |c| counts[c] += 1 unless c == ' ' }
#   return counts
# end

def letter_count(str)
  letter_hash = Hash.new(0)
  str.gsub(" ", "").each_char { |char| letter_hash[char] += 1 }
  letter_hash
end
