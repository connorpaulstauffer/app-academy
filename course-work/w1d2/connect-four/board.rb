require "byebug"

class Board

  def initialize
    @grid = Array.new(6) { Array.new(7) { " " } }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, val)
    @grid[row][col] = val
  end

  def drop_disc(col_index, disc)
    (0..5).to_a.reverse.each do |row_index|
      if self[row_index, col_index] == " "
        self[row_index, col_index] = disc
        return [row_index, col_index]
      end
    end
    nil
  end

  def four_in_a_row?(piece)
    sequences = rows + cols + forward_diagonals + backward_diagonals
    sequences.any? do |sequence|
      sequence.join("").include?(piece * 4)
    end
  end

  def rows
    @grid
  end

  def cols
    @grid.transpose
  end

  def forward_diagonal_from(index)
    row, col = index
    values = []
    until row < 0 || col >= @grid.first.length
      values << self[row, col]
      row -= 1
      col += 1
    end
    values
  end

  def forward_diagonals
    diagonals = []
    start_positions = (0..5).map { |row| [row, 0] } + (1..6).map { |col| [5, col] }

    start_positions.each do |start_pos|
      diagonals << forward_diagonal_from(start_pos)
    end

    diagonals
  end

  def backward_diagonal_from(index)
    row, col = index
    values = []
    until row < 0 || col < 0
      values << self[row, col]
      row -= 1
      col -= 1
    end
    values
  end

  def backward_diagonals
    diagonals = []
    start_positions = (0..5).map { |row| [row, 6] } + (0..5).map { |col| [5, col] }

    start_positions.each do |start_pos|
      diagonals << backward_diagonal_from(start_pos)
    end

    diagonals
  end

  def render
    output = @grid.map do |row|
      row.map do |element|
        element == " " ? "o" : element
      end.join(" ")
    end.join("\n")

    puts output
  end

end
