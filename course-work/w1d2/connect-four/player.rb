require "colorize"

class Player
  def initialize(piece)
    @piece = piece
  end

  def piece
    @piece == "r" ? @piece.light_red : @piece.cyan
  end

end
