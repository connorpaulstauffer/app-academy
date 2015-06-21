
class Player

  attr_reader :board, :name

  def initialize(name)
    @name = name
    @board = Board.new
  end

  def defeated?
    @board.all_targets_sunk?
  end

  def display_board(for_opponent = false)
    @board.display(for_opponent)
  end

end


class ComputerPlayer < Player

  def initialize(name)
    super(name)
    @board.setup_ships
  end

  def get_move(opponent)
    open_positions = opponent.board.open_positions
    attack_pos = open_positions.sample
    result = opponent.board.attack(attack_pos)
    [result, attack_pos]
  end

end


class HumanPlayer < Player

  def initialize(name)
    super(name)
    @board.setup_ships
  end

  def get_move(opponent)
    loop do
      letter_hash = {
                      'a' => 0, 'b' => 1, 'c' => 2, 'd' => 3, 'e' => 4,
                      'f' => 5, 'g' => 6, 'h' => 7, 'i' => 8, 'j' => 9
                    }
      print "#{@name}, enter your attack row: "
      row = letter_hash[gets.chomp]
      print "#{@name}, enter your attack column: "
      col = gets.chomp.to_i - 1
      if opponent.board.open_positions.include?([row, col])
        result = opponent.board.attack([row, col])
        return [result, [row, col]]
      end
      puts "Invalid move. Try again."
    end
  end


end
