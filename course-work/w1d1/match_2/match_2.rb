require './board.rb'
require './player.rb'
require './card.rb'

class Game
  attr_reader :size

  def initialize
    setup_board
    @player = setup_player
    @previously_guessed_position = nil
    @turns = 0
    play
  end

  def setup_player
    type = nil
    loop do
      print "Human or AI?(h or a): "
      type = gets.chomp
      break if type == 'a' || type == 'h'
    end
    type == 'a' ? ComputerPlayer.new(self) : HumanPlayer.new(self)
  end

  def setup_board
    size = 0
      loop do
        puts "Enter a board size"
        size = gets.chomp.to_i
        break if size % 2 == 0 && size >= 0
        puts "Board size has to be even"
      end
      @board = Board.new(size)
      @size = size
  end

  def play
    until over?
      @turns += 1
      @board.render
      position = @player.get_guess
      make_guess(position)
    end
    puts @board.won? ? "Congratulations, you won!" : "Sorry. You Lost."
  end

  def over?
    @board.won? || @turns >= (@board.grid.length ** 2) * 2
  end

  def valid_guess?(guess)
    guess != nil && guess_in_range?(guess) && @board[*guess].state == :hidden
  end

  def guess_in_range?(guess)
    guess.all? { |idx| (0..@board.grid.length).include?(idx) }
  end

  def make_guess(position)
    current_card = @board[*position]
    @player.receive_card_value(current_card.value)
    current_card.reveal
    if @previously_guessed_position
      @board.render
      previous_card = @board[*@previously_guessed_position]
      unless current_card == previous_card
        #sleep(3)
        [current_card, previous_card].each { |card| card.hide }
      end
      @previously_guessed_position = nil
    else
      @previously_guessed_position = position
    end
  end

end


if __FILE__ == $PROGRAM_NAME
  Game.new
end
