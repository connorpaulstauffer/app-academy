require_relative "board"
require_relative "player"
require "colorize"

class Game
  def initialize
    @board = Board.new
    @player_one = Player.new("r")
    @player_two = Player.new("b")
    @active_player = @player_one
  end

  def winner
    return @player_one if @board.four_in_a_row?(@player_one.piece)
    return @player_two if @board.four_in_a_row?(@player_two.piece)
    nil
  end

  def over?
    winner
  end

  def run
    until over?
      @board.render
      prompt
      switch_players
    end
    @board.render
    puts "Congratulations, player #{winner.piece}."
  end

  def switch_players
    @active_player = (@active_player == @player_one) ? @player_two : @player_one
  end

  def prompt
    loop do
      print "Player #{@active_player.piece}, enter a Column: "
      col = gets.chomp.to_i
      break if @board.drop_disc(col, @active_player.piece)
    end
  end
end
