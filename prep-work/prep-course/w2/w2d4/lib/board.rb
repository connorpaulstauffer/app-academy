require 'command_line_reporter'

class Board

  include CommandLineReporter

  attr_accessor :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, nil) }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def three_in_a_row?(piece)
    sets.any? { |set| set.count(piece) == 3 }
  end

  def positions
    positions = []
    0.upto(2) { |m| 0.upto(2) { |n| positions << [m, n] } }
    positions
  end

  def empty_positions
    positions.select { |position| self[*position].nil? }
  end

  def display
    table(border: true) { 3.times { |row_idx| display_row(row_idx) } }
  end

  def copy_grid
    Marshal::load(Marshal.dump(@grid))
  end

  private

    def display_row(row_idx)
      row { 3.times { |col_idx| display_element(row_idx, col_idx) } }
    end

    def display_element(row_idx, col_idx)
      column(stringize(self[row_idx, col_idx]), width: 3, align: 'center')
    end

    def stringize(el)
      el.nil? ? '' : el.to_s
    end

    def rows
      @grid
    end

    def cols
      @grid.transpose
    end

    def diagonals
      [
        [self[0, 0], self[1, 1], self[2,2]],
        [self[0, 2], self[1, 1], self[2, 0]]
      ]
    end

    def sets
      rows + cols + diagonals
    end

end
