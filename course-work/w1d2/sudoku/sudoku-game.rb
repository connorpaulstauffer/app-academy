require_relative 'board'
require_relative 'player'

class SudokuGame

  def initialize(file_name, player)
    @board = Board.from_file(file_name)
    @player = player
    @player.set_board(@board)
  end

  def play
    until @board.solved?
      @board.render
      @player.get_move
    end
    @board.render
    "Congratulations. You won!"
  end

end
