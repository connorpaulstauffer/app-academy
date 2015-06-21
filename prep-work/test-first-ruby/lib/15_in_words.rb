class Fixnum

  @@englishOnes = { 9 => "nine", 8 => "eight", 7 => "seven", 6 => "six",
                      5 => "five", 4 => "four", 3 => "three", 2 => "two",
                      1 => "one"}
  @@englishTeens  = { 9 => "nineteen", 8 => "eighteen", 7 => "seventeen",
                      6 => "sixteen", 5 => "fifteen", 4 => "fourteen",
                      3 => "thirteen", 2 => "twelve", 1 => "eleven"}
  @@englishTens   = { 9 => "ninety", 8 => "eighty", 7 => "seventy",
                      6 => "sixty", 5 => "fifty", 4 => "forty", 3 => "thirty",
                      2 => "twenty", 1 => "ten"}
  @@ranges = ["digit", "thousand", "million", "billion", "trillion"]

  def in_words
    return "zero" if self == 0
    parts_in_words(self).join(" ")
  end

  def parts_in_words number
    hash = hashize_number number
    hash = stringize_hash hash
    sort_range_hash hash
  end

  def sort_range_hash hash
    hash.sort_by { |key, val| -@@ranges.index(key) }.map { |arr| arr[1] }
  end

  def hashize_number number
    str = number.to_s
    hash = Hash.new
    i = 0
    while str.length > 0
      if i == @@ranges.length - 1 || str.length < 3
        hash[@@ranges[i]] = str.slice!(0..-1).to_i
      else
        hash[@@ranges[i]] = str.slice!(-3..-1).to_i
      end
      i += 1
    end
    hash.select {|key, val| val != 0 }
  end

  def stringize_hash hash
    hash.each do |key, val|
      if key == "digit"
        hash[key] = digits_in_words val
      else
        hash[key] = large_in_words val, key
      end
    end
  end

  def digits_in_words number
    if number > 99
      english_hundreds = "#{@@englishOnes[number / 100]} hundred"
      number %= 100
    else
      english_hundreds = ""
    end
    if number > 9
      english_tens = @@englishTens[number / 10]
      number %= 10
    else
      english_tens = ""
    end
    if number > 0
      if english_tens == "ten"
        english_tens = @@englishTeens[number]
        english_ones = ""
      else
        english_ones = @@englishOnes[number]
      end
    else
      english_ones = ""
    end
    [english_hundreds, english_tens, english_ones].select { |str| !str.empty? }.join(" ")
  end

  def large_in_words number, string
    "#{digits_in_words number} #{string[0..-1]}"
  end

end
