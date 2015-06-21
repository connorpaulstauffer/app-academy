class HumanPlayer

  attr_reader :name, :piece

  def initialize(name, piece)
    @name, @piece = name, piece
  end

  def get_move(game)
    loop do
      print "Enter row: "
      row = gets.chomp.to_i - 1
      print "Enter col: "
      col = gets.chomp.to_i - 1
      return [row, col] if game.valid_move?([row, col])
      puts "Invalid move. Try again."
    end
  end

end
