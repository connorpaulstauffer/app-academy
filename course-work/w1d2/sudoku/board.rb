require_relative 'tile'
require "byebug"

class Board

  def initialize(tile_grid)
    @tile_grid = tile_grid
  end

  def self.from_file(file)
    grid = File.readlines(file).map do |row|
      row.chomp.chars.map { |char| Tile.new(char) }
    end
    Board.new(grid)
  end

  def []=(row, col, val)
    @tile_grid[row][col].value = val
  end

  def [](row, col)
    @tile_grid[row][col].value
  end

  def render
    x = @tile_grid.map.with_index do |row, row_idx|
      row_output = row.map.with_index do |tile, idx|
        output = tile.to_s
        idx % 3 == 0 ? ' ' + output : output
      end.join(" ")
      row_idx % 3 == 0 ? "\n" + row_output : row_output
    end.join("\n")
    puts x
  end

  def solved?
    all_cols_solved? && all_rows_solved? && all_blocks_solved?
  end

  def row_solved?(idx)
    return false if @tile_grid[idx].any? { |tile| !tile.value }
    @tile_grid[idx].map(&:value).sort == (1..9).to_a
  end

  def all_rows_solved?
    (0..8).to_a.all? { |row_idx| row_solved?(row_idx) }
  end

  def row(idx)
    @tile_grid[idx]
  end

  def row_invalid?(idx)
    row = row(idx).map(&:value)
    row.any? { |tile| row.count(tile) > 1 }
  end

  def any_rows_invalid?
    (0..8).to_a.any? { |row_idx| row_invalid?(row_idx) }
  end

  def col(idx)
    col = []
    (0..8).each do |row|
      col << @tile_grid[row][idx]
    end
    col
  end

  def col_solved?(idx)
    return false if col(idx).any? { |tile| !tile.value }
    col(idx).map(&:value).sort == (1..9).to_a
  end

  def all_cols_solved?
    (0..8).to_a.all? { |col_idx| col_solved?(col_idx) }
  end

  def col_invalid?(idx)
    col = col(idx).map(&:value)
    col.any? { |tile| col.count(tile) > 1 }
  end

  def any_cols_invalid?
    (0..8).to_a.any? { |col_idx| col_invalid?(col_idx) }
  end

  def block(index)
    row, col = index.map { |idx| (idx / 3).floor * 3 }
    block = []
    (0..2).each do |add_to_row|
      (0..2).each do |add_to_col|
        block << @tile_grid[row + add_to_row][col + add_to_col]
      end
    end
    block
  end

  def block_solved?(topleft_corner)
    return false if block(topleft_corner).any? { |tile| !tile.value }
    block(topleft_corner).map(&:value).sort == (1..9).to_a
  end

  def all_blocks_solved?
    [
      [0,0], [0,3], [0, 6],
      [3,0], [3,3], [3,6],
      [6,0], [6,3], [6,6]
    ].all? { |pos| block_solved?(pos) }
  end

  def block_invalid?(idx)
    block = block(idx).map(&:value)
    block.any? { |tile| block.count(tile) > 1 }
  end

  def any_blocks_invalid?
    [
      [0,0], [0,3], [0, 6],
      [3,0], [3,3], [3,6],
      [6,0], [6,3], [6,6]
    ].any? { |pos| block_invalid?(pos) }
  end

  def invalid?
    any_rows_invalid? || any_cols_invalid? || any_blocks_invalid?
  end

  def valid_positions
    valid_coords = []

    (0..8).each do |row|
      (0..8).each do |col|
        valid_coords << [row, col] if self[row, col].nil?
      end
    end

    valid_coords
  end

end
