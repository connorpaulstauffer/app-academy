class TicTacToe

  attr_accessor :board, :player1, :player2

  def initialize(player1, player2)
    @player1, @player2, @board = player1, player2, Board.new
  end

  def play
    @board.display

    loop do
      [@player1, @player2].each do |player|
        puts "\n#{player.name}'s turn."
        move(player)
        break if winner || draw?
      end
      break if winner || draw?
    end
    draw? ? announce_draw : congratulate_winner
  end

  def valid_move?(pos)
    valid_moves.include?(pos)
  end

  def valid_moves
    @board.empty_positions
  end

  def winning_move?(pos, piece)
    new_board = Board.new
    new_board.grid = @board.copy_grid
    new_board[*pos] = piece
    new_board.three_in_a_row?(piece)
  end

  private

    def move(player)
      move = player.get_move(self)
      @board[*move] = player.piece
      @board.display
      announce_move(move, player)
    end

    def winner
      return @player1 if winner?(@player1)
      return @player2 if winner?(@player2)
      nil
    end

    def winner?(player)
      @board.three_in_a_row?(player.piece)
    end

    def draw?
      valid_moves.empty?
    end

    def congratulate_winner
      print "\nCongatulations, #{winner.name}!\n\n"
    end

    def announce_draw
      print "\nIt's a draw!\n\n"
    end

    def announce_move(move, player)
      move.map! { |pos| pos += 1 }
      puts "#{player.name} moved to (#{move.join(', ')})"
    end

end
