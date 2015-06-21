load 'lib/piece.rb'

class Board

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    setup_pieces
  end

  def setup_pieces
    piece_sequence = [Rook, Knight, Bishop, King, Queen, Bishop, Knight, Rook]
    @grid[0] = piece_sequence.map { |piece| piece.new(:white) }
    @grid[1] = Array.new(8) { Pawn.new(:white) }
    @grid[6] = Array.new(8) { Pawn.new(:black) }
    @grid[7] = piece_sequence.map { |piece| piece.new(:black) }
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def move(from, to)
    return false unless @grid[*from].valid_move?(from, to)
    return false unless path_clear?(from, to) || @grid[*from].class == Knight
    @grid[*to], @grid[*from] = @grid[*from], nil
  end

  def path_clear?(from, to)
    return diagonal_clear?(from, to) if diagonal_movement?(from, to)
    return horizontal_clear?(from, to) if horizontal_movement?(from, to)
    return vertical_clear?(from, to) if vertical_movement?(from, to)
    false
  end

  def diagonal_movement?(from, to)
    vertical = to[0] - from[0]
    horizontal = to[1] - from[1]
    vertical.abs == horizontal.abs && vertical.abs > 0
  end

  def horizontal_movement?(from, to)
    vertical = to[0] - from[0]
    horizontal = to[1] - from[1]

    horizontal.abs > 0 && vertical == 0
  end

  def vertical_movement?(from, to)
    vertical = to[0] - from[0]
    horizontal = to[1] - from[1]

    vertical.abs > 0 && horizontal == 0
  end


  def diagonal_clear?(from, to)
    vertical = to[0] - from[0]
    horizontal = to[1] - from[1]
    vertical_constant = vertical / vertical.abs
    horizontal_constant = horizontal / horizontal.abs

    pos = [from[0] + vertical_constant, from[1] + horizontal_constant]
    until pos == to
      return false unless @grid[*pos].nil?
      pos = [pos[0] + vertical_constant, pos[1] + horizontal_constant]
    end
    true
  end

  def horizontal_clear?(from, to)
    horizontal = to[1] - from[1]
    horizontal_constant = horizontal / horizontal.abs

    pos = [from[0], from[1] + horizontal_constant]
    until pos == to
      return false unless @grid[*pos].nil?
      pos = [pos[0], pos[1] + horizontal_constant]
    end
    true
  end

  def vertical_clear?(from, to)
    vertical = to[0] - from[0]
    vertical_constant = vertical / vertical.abs

    pos = [from[0] + vertical_constant, from[1]]
    until pos == to
      return false unless @grid[*pos].nil?
      pos = [pos[0] + vertical_constant, pos[1]]
    end
    true
  end

  def print

  end



end
