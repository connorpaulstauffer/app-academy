# def no_repeats(year_start, year_end)
#   arr = []
#   year_start.upto(year_end) do |year|
#     arr << year if no_repeats?(year)
#   end
#   return arr
# end

# def no_repeats?(year)
#   year = year.to_s
#   return year.length == year.chars.uniq.length
# end

# def no_repeats(year_start, year_end)
#   arr = []
#   year_start.upto(year_end) do |y|
#     arr << y if no_repeats?(y)
#   end
#   return arr
# end

# def no_repeats?(year)
#   year = year.to_s
#   return year.length == year.chars.uniq.length
# end

# def no_repeats(year_start, year_end)
#   return (year_start..year_end).to_a.select do |y|
#            y.to_s.length == y.to_s.chars.uniq.length
#          end
# end

def no_repeats(start_year, end_year)
  (start_year..end_year).to_a.select { |year| no_repeat?(year) }
end

def no_repeat?(year)
  year.to_s.chars == year.to_s.chars.uniq
end
