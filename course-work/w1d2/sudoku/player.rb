require 'byebug'
class HumanPlayer

  def set_board(board)
    @board = board
  end

  def get_move
    puts "Specify row, column and value('row, col, val'):"
    row, col, value = gets.chomp.gsub(" ", "").split(",").map(&:to_i)
    @board[row, col] = value
  end

end


class ComputerPlayer

  def set_board(board)
    @board = board
    @obvious_moves_left = true
  end

  def get_move
    if @obvious_moves_left
      obvious = obvious_move
      return obvious if obvious
    end
    brute_force_move
  end

  def brute_force_move
    
  end

  def obvious_move
    @board.valid_positions.each do |pos|
      value = only_option(pos)
      return @board[*pos] = value if value
    end
  end

  def only_option(pos)
    row_index, col_index = pos

    not_in_row = (1..9).to_a - @board.row(row_index).map(&:value).compact
    not_in_col = (1..9).to_a - @board.col(col_index).map(&:value).compact
    not_in_block = (1..9).to_a - @board.block(pos).map(&:value).compact

    not_in_any = not_in_row & not_in_col & not_in_block

    return not_in_any.first if not_in_any.length == 1

    @obvious_moves_left = false
    nil
  end


end
