
# Write a method that takes an array of integers and returns an array with the
# array elements multiplied by two.
def multiply_by_two array
  array.map { |el| el * 2 }
end

class Array

  # Extend the Array class to include a method named my_each that takes a block,
  # calls the block on every element of the array, and then returns the original
  # array. Do not use Ruby's Enumerable's each method. I want to be able to write:
  def my_each
    0.upto(self.length - 1) { |el| yield el }
    self
  end

  # Write a method that finds the median of a given array of integers. If the
  # array has an odd number of integers, return the middle item from the sorted
  # array. If the array has an even number of integers, return the average of
  # the middle two items from the sorted array. (You actually don't need to use
  # any enumerable methods for this).
  def median
    sorted = self.sort
    mid = sorted.length / 2.0
    if mid % 1 == 0
      (sorted[mid] + sorted[mid - 1]) / 2.0
    else
      sorted[mid.to_i]
    end
  end

end

# Create a method that takes in an Array of Strings and uses inject to return
# the concatenation of the strings.
def concatenate array
  array.inject(:+)
end
