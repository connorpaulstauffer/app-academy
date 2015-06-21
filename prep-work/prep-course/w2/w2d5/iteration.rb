require 'set'

def factors(number)
  1.upto(number) { |val| puts val if number % val == 0 }
end

def bubble_sort(array)
  sorted = false
  until sorted
    sorted = true
    0.upto(array.length - 2) do |i|
      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        sorted = false
      end
    end
  end
  array
end

def substrings(string)
  substrings = []
  0.upto(string.length - 1) do |start_idx|
    start_idx.upto(string.length - 1) do |end_idx|
      substrings << string[start_idx..end_idx]
    end
  end
  substrings
end

def subwords(string)
  words = Set.new(File.readlines("dictionary.txt").map(&:chomp))
  substrings(string).select { |substring| words.include?(substring) }
end
