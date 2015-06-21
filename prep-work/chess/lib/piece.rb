
class Piece

  attr_reader :position

  def initialize(player)
    @player = player
  end

  def player_constant
    @player == :white ? 1 : -1
  end

end


class Pawn < Piece

  def initialize(player)
    super(player)
  end

  def valid_move?(from, to)
    from[0] += player_constant
    return true if from == to
    from[0] += player_constant
    from == to
  end

  def valid_attack?(from, to)
    return false unless from[0] + 1 == to[0]
    from[1] + 1 == to[1] || from[1] - 1 == to[1]
  end

end


class King < Piece

  def initialize(player)
    super(player)
  end

  def valid_move?(from, to)
    vertical = (from[0] - to[0]).abs
    horizontal = (from[1] - to[1]).abs
    return false if vertical > 1 || horizontal > 1
    vertical == 1 || horizontal == 1
  end

  end

end


class Queen < Piece

  def initialize(player)
    super(player)
  end

  def valid_move?(from, to)
    vertical = to[0] - from[0]
    horizontal = to[1] - from[1]

    vertical_move = horizontal == 0 && vertical.abs > 0
    horizontal_move = horizontal.abs > 0 && vertical == 0
    diagonal_move = horizontal.abs == vertical.abs && vertical != 0

    vertical_move || horizontal_move || diagonal_move
  end

end


class Rook < Piece

  def initialize(player)
    super(player)
  end

  def valid_move?(from, to)
    vertical = to[0] - from[0]
    horizontal = to[1] - from[1]

    vertical_move = horizontal == 0 && vertical.abs > 0
    horizontal_move = horizontal.abs > 0 && vertical == 0

    vertical_move || horizontal_move
  end

end


class Bishop < Piece

  def initialize(player)
    super(player)
  end

  def valid_move?(from, to)
    vertical = to[0] - from[0]
    horizontal = to[1] - from[1]

    horizontal.abs == vertical.abs && vertical != 0
  end

end


class Knight < Piece

  def initialize(player)
    super(player)
  end

  def valid_move?(from, to)
    vertical = to[0] - from[0]
    horizontal = to[1] - from[1]

    two_and_three = vertical.abs == 2 && horizontal.abs == 3
    three_and_two = vertical.abs == 3 && horizontal.abs == 2

    two_and_three || three_and_two
  end

end
