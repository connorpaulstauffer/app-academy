
def solve(n)
  queen_locations = (0...n).to_a
  column_locations = queen_locations.permutation(n).to_a
  column_locations.each do |ordering|
    return ordering if is_valid?(ordering)
  end
  puts "Couldn't find anything"
end

def is_valid?(locations)
  locations.each_with_index do |col_1_i, row_1_i|
    locations.each_with_index do |col_2_i, row_2_i|
      unless row_1_i == row_2_i
        return false if (row_2_i - row_1_i).abs == (col_2_i - col_1_i).abs
      end
    end
  end
  return true
end

def render(locations)
  output = (0...locations.length).map do |row|
             (0...locations.length).map do |idx|
               idx == locations[row] ? "Q" : "*"
             end.join(" ")
           end.join("\n")
  puts output
end

render(solve(10))
