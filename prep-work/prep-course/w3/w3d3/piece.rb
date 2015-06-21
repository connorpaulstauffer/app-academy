require 'colored'

class Piece

  attr_reader :orientation

  def initialize(board)
    @board = board
    @orientation = [:horizontal, :vertical].sample
  end

  def set_positions
    vertical = [true, false].sample
    row_limit = vertical ? 10 - @length : 9
    col_limit = vertical ? 9 : 10 - @length
    @positions = map_positions((0..row_limit).to_a.sample, (0..col_limit).to_a.sample, vertical)
  end

  def map_positions(start_row, start_col, vertical)
    position_hash = {}
    if vertical
      (start_row...(start_row + length)).each do |row|
        position_hash[[row, start_col]] = false
      end
    else
        (start_col...(start_col + length)).each do |col|
          position_hash[[start_row, col]] = false
        end
    end
    position_hash
  end

  def hit?(pos)
    @positions[pos]
  end

  def stringize(pos, for_opponent)
    for_opponent && !hit?(pos) ? "" : self.class.to_s[0]
  end

  def positions
    @positions.keys
  end

  def attack(pos)
    @positions[pos] = true
  end

  def sunk?
    @positions.values.all?
  end

end


class AircraftCarrier < Piece

  attr_reader :length

  def initialize(board)
    super(board)
    @length = 5
    set_positions
  end

end


class Battleship < Piece

  attr_reader :length

  def initialize(board)
    super(board)
    @length = 4
    set_positions
  end

end


class Submarine < Piece

  attr_reader :length

  def initialize(board)
    super(board)
    @length = 3
    set_positions
  end

end


class Destroyer < Piece

  attr_reader :length

  def initialize(board)
    super(board)
    @length = 3
    set_positions
  end

end


class PatrolBoat < Piece

  attr_reader :length

  def initialize(board)
    super(board)
    @length = 2
    set_positions
  end

end
