
class Array

  # Write your own uniq method, called my_uniq; it should take in an Array and
  # return a new array.
  def my_uniq
    unique_items = []
    self.each{ |item| unique_items << item if !unique_items.include?(item) }
    unique_items
  end

  # Write a new Array#two_sum method that finds all pairs of positions where
  # the elements at those positions sum to zero.
  def two_sum
    zero_sum_pairs = []
    last_index = self.length - 1
    0.upto(last_index) do |i|
      (i + 1).upto(last_index) do |j|
        zero_sum_pairs << [i, j] if (self[i] + self[j] == 0)
      end
    end
    zero_sum_pairs
  end

end

# Write a method, my_transpose, which will convert between the row-oriented and
# column-oriented representations.
def my_transpose(matrix)
  transpose = []
  0.upto(matrix[0].length - 1) do |c|
    row = []
    matrix.each do |r|
      row << r[c]
    end
    transpose << row
  end
  transpose
end

# Write a method that takes an array of stock prices (prices on days 0, 1, ...),
# and outputs the most profitable pair of days on which to first buy the stock
# and then sell the stock.
def stock_picker prices
  max_profit = 0
  best_days = [0, 0]
  0.upto(prices.length - 1) do |buy_idx|
    buy_idx.upto(prices.length - 1) do |sell_idx|
      if prices[sell_idx] - prices[buy_idx] > max_profit
        max_profit = prices[sell_idx] - prices[buy_idx]
        best_days = [buy_idx, sell_idx]
      end
    end
  end
  best_days
end
