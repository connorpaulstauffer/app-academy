
class Game

  def initialize
    @board = Board.new.setup_pieces
    @player1 = :black
    @player2 = :white
  end


end
