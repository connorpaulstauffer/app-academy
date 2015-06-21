# x = 1204000000
# seconds_in_minute = 60
# seconds_in_hour = seconds_in_minute * 60
# seconds_in_day = seconds_in_hour * 24
# seconds_in_year = seconds_in_day * 365
# puts "#{x / seconds_in_year} years"
# x = x % seconds_in_year
# puts "#{x / seconds_in_day} days"
# x = x % seconds_in_day
# puts "#{x / seconds_in_hour} hours"
# x = x % seconds_in_hour
# puts "#{x / seconds_in_minute} minutes"
# x = x % seconds_in_minute
# puts "#{x} seconds"

# puts "What's your first name?"
# first = gets.chomp
# puts "What's your middle name?"
# middle = gets.chomp
# puts "What's your last name?"
# last = gets.chomp
# puts "#{first} #{middle} #{last}"

# puts "What's your favorite number?"
# fav = gets.chomp
# puts "#{fav.to_i + 1} is a bigger and better number"

# puts "what do you want?".upcase
# ans = gets.chomp
# puts "whadayya mean \"#{ans}\"?!? You\'re fired!!".upcase

# content = [ 
#               ["Table of Contents"],
#               ["Chapter 1:  Numbers", "page 1"], 
#               ["Chapter 2:  Letters", "page 72"],
#               ["Chapter 3:  Variables", "page 118"]
#             ]
# width = 50
# content.each do |line| 
#   if line.length == 1
#     puts line[0].center(width)
#   else
#     puts line[0].ljust(width / 2) + line[1].rjust(width / 2) 
#   end
# end

# 99.downto(1) { |i| puts "#{i} bottle of beer on the wall, " +
#                         "#{i} bottles of beer. take one down, " + 
#                         "pass it around, #{i - 1} bottles of beer on the wall" 
#               }

# command = ""
# counter = 0
# while (counter < 2 || command != "BYE")
#   if command == ""
#     puts "HELLO, SONNY!"
#     counter = 0
#   elsif command == "BYE"
#     counter += 1
#   elsif command.upcase == command
#     puts "NO, NOT SINCE #{rand(21) + 1930}."
#     counter = 0
#   else
#     puts "HUH?! SPEAK UP, SONNY!"
#     counter = 0
#   end
#   command = gets.chomp
# end
# puts command

# puts "Enter a start year"
# start_year = gets.chomp.to_i
# puts "Enter an end year"
# end_year = gets.chomp.to_i
# start_year.upto(end_year) do |y|
#   puts y if (y % 4 == 0) && (y % 100 != 0 || y % 400 == 0)
# end

# words = []

# word = gets.chomp
# while word != ""
#   words << word
#   word = gets.chomp
# end

# #words.sort.each { |w| puts w }

# swapped = true
# while swapped
#   swapped = false
#   0.upto(words.length - 2) do |i|
#     if words[i] > words[i + 1]  
#       words[i], words[i + 1] = words[i + 1], words[i]
#       swapped = true
#     end
#   end    
# end

# words.each { |w| puts w }

# def saymoo number_of_moos = 1
#   puts "moooo" * number_of_moos
#   "this is the return value because it is on the last line"
# end

# def englishNumber number
#   return "zero" if number == 0  # skip the rest of the method
  
#   # Seperate and identify these values
#   trillions = number / 1000000000000
#   number %= 1000000000000
#   billions = number / 1000000000
#   number %= 1000000000
#   millions = number / 1000000
#   number %= 1000000
#   thousands = number / 1000
#   number %= 1000
#   hundreds = number / 100
#   number %= 100
#   tens = number / 10
#   number %= 10
  
#   if trillions > 0
#     english_trillions = "#{englishNumber(trillions)} trillion"
#   else
#     english_trillions = ""
#   end
  
#   if billions > 0
#     english_billions = "#{englishNumber(billions)} billion"
#   else
#     english_billions = ""
#   end
  
#   if millions > 0
#     english_millions = "#{englishNumber(millions)} million"
#   else
#     english_millions = ""
#   end
  
#   if thousands > 0
#     english_thousands = "#{englishNumber(thousands)} thousand"
#   else
#     english_thousands = ""
#   end
  
#   if hundreds > 0
#     english_hundreds = "#{englishDigit(hundreds)}-hundred"
#   else
#     english_hundreds = ""
#   end
  
#   if tens > 0
#     english_tens = englishTen(tens)
#   else
#     english_tens = ""
#   end
  
#   if number > 0
#     if english_tens == "ten"
#       english_tens = englishTeen number
#       english_digits = ""
#     else
#       english_digits = englishDigit number
#     end
#   else
#     english_digits = ""
#   end
  
#   string = ""
#   string << english_trillions
#   string << ((english_trillions == "") ? english_billions : " #{english_billions}")
#   string << ((english_billions == "") ? english_millions : " #{english_millions}")
#   string << ((english_millions == "") ? english_thousands : " #{english_thousands}")
#   string << ((english_thousands == "") ? english_hundreds : " #{english_hundreds}")
#   string << ((english_hundreds == "") ? english_tens : " #{english_tens}")
#   if english_digits != ""
#     if english_tens == ""
#       string << " #{english_digits}"
#     else
#       string << "-#{english_digits}"
#     end
#   end  
#   string
# end

# def englishDigit digit
#   if digit == 9
#     return "nine"
#   elsif digit == 8
#     return "eight"
#   elsif digit == 7
#     return "seven"
#   elsif digit == 6
#     return "six"
#   elsif digit == 5
#     return "five"
#   elsif digit == 4
#     return "four"
#   elsif digit == 3
#     return "three"
#   elsif digit == 2
#     return "two"
#   elsif digit == 1
#     return "one"
#   else
#     return nil
#   end
# end

# def englishTen digit
#   if digit == 9
#     return "ninety"
#   elsif digit == 8
#     return "eighty"
#   elsif digit == 7
#     return "seventy"
#   elsif digit == 6
#     return "sixty"
#   elsif digit == 5
#     return "fifty"
#   elsif digit == 4
#     return "fourty"
#   elsif digit == 3
#     return "thirty"
#   elsif digit == 2
#     return "twenty"
#   elsif digit == 1
#     return "ten"
#   else
#     return nil
#   end
# end

# def englishTeen digit
#   if digit == 9
#     return "nineteen"
#   elsif digit == 8
#     return "eighteen"
#   elsif digit == 7
#     return "seventeen"
#   elsif digit == 6
#     return "sixteen"
#   elsif digit == 5
#     return "fifteen"
#   elsif digit == 4
#     return "fourteen"
#   elsif digit == 3
#     return "thirteen"
#   elsif digit == 2
#     return "twelve"
#   elsif digit == 1
#     return "eleven"
#   else
#     return nil
#   end
# end

# def beerOnTheWall number  
#   number.downto(1) { |i| puts "#{englishNumber i} bottle of beer on the wall, " +
#                           "#{englishNumber i} bottles of beer. take one down, " + 
#                           "pass it around, #{englishNumber(i - 1)} bottles of beer on the wall" 
#                 }    
# end        
    
    
# def birthday_spanks
#   puts "What year were you born?"
#   year = gets.chomp
#   puts "What month were you born?"
#   month = gets.chomp
#   puts "What day were you born?"
#   day = gets.chomp
#   age = ((Time.new - Time.mktime(year, month, day)) / (60 * 60 * 24 * 365)).to_i 
#   age.times { puts "SPANK!" }
# end
  

class Die
  
  def initialize
    roll
  end
  
  def roll
    @number = rand(6) + 1
  end
  
  def show
    @number
  end

  def cheat side
    @number = side if side < 7 && side > 0
  end
  
end

class OrangeTree
  
  def initialize
    @age = 0
    @height = 0
    @oranges = 0
  end
  
  def height
    @height
  end
  
  def age
    @age
  end
  
  def pickAnOrange
    if @oranges > 0
      @oranges -= 1
      puts "That was delicious!"
    else
      puts "There are no oranges!"
    end
  end
  
  def countOranges
    @oranges
  end
  
  def oneYearPasses
    @age += 1
    @height += 2
    @oranges = @age if age > 2
    if @age > 9
      puts "The tree has died"
      exit
    end
  end
  
end

class Dragon
  
  def initialize name
    @name = name
    leave = false
    while !leave
      command = gets.chomp
      self.walk if command == "walk"
      leave = true if command == "leave"
    end
  end
  
  def walk
    puts "You're walking #{@name}"
  end
  
end

def grandfatherClock &block
  (Time.now.hour + 1).times do
    block.call
  end
end

$nesting_depth = 0

def log description, &block
  $nesting_depth += 1
  puts "#{" " * $nesting_depth}Beginning \"#{description}\"..."
  puts "#{" " * $nesting_depth}...\"#{description}\" finished, returning: #{block.call}"
end

log "some block" do
  log "another block" do
    log "last block" do
      3
    end
    2
  end
  1
end
  
  
    
    
    
    
  
  

