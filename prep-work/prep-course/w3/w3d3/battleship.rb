load 'board.rb'
load 'piece.rb'
load 'player.rb'

class BattleshipGame

  def initialize
    setup
    @up_next = @player1
    @on_deck = @player2
    play
  end

  def setup
    print "Player 1, computer or human? Enter 'c' or 'h': "
    loop do
      type = gets.chomp
      if type == 'c' || type == 'h'
        print "Enter a name for Player 1: "
        name = gets.chomp
        @player1 = (type == 'c') ? ComputerPlayer.new(name) : HumanPlayer.new(name)
        break
      end
      print "Enter 'c' or 'h': "
    end

    print "Player 2, computer or human? Enter 'c' or 'h': "
    loop do
      type = gets.chomp
      if type == 'c' || type == 'h'
        print "Enter a name for Player 2: "
        name = gets.chomp
        @player2 = (type == 'c') ? ComputerPlayer.new(name) : HumanPlayer.new(name)
        break
      end
      print "Enter 'c' or 'h': "
    end
  end

  def play
    loop do
      execute_turn
      break if over?
    end
    announce_winner
  end

  def execute_turn
    Turn.new(@up_next, @on_deck)
    swap_players
  end

  def swap_players
    @up_next, @on_deck = @on_deck, @up_next
  end

  def over?
    @player1.defeated? || @player2.defeated?
  end

  def announce_winner
    print "\n\n"
    print @player2.defeated? ? @player1.name : @player2.name
    puts " wins!"
  end

end


class Turn

  attr_reader :active_player

  def initialize(active_player, passive_player)
    @active_player = active_player
    @passive_player = passive_player
    prompt_user
    print_active_result unless @active_player.class == ComputerPlayer
    print_passive_result unless @passive_player.class == ComputerPlayer
  end

  def get_enter(player)
    loop do
      print "#{player.name}, press enter to continue "
      break if gets.chomp == ""
    end
  end

  def prompt_user
    unless @active_player.class == ComputerPlayer
      get_enter(@active_player)
      @passive_player.display_board(true)
    end
    @result, @pos = @active_player.get_move(@passive_player)
  end

  def print_active_result
    target = (@result == :X) ? "nothing" : "#{@passive_player.name}'s #{@result.class}"
    sunk_or_hit = (@result == :X || !@result.sunk?) ? "hit" : "sunk"
    puts "\nYou #{sunk_or_hit} #{target} at #{display_pos(@pos)}."
    @passive_player.display_board(true)
    get_enter(@passive_player)
  end

  def print_passive_result
    target = (@result == :X) ? "nothing" : "your #{@result.class}"
    sunk_or_hit = (@result == :X || !@result.sunk?) ? "hit" : "sunk"
    puts "\n#{@passive_player.name}: #{@active_player.name} #{sunk_or_hit} #{target} at #{display_pos(@pos)}."
    @passive_player.display_board
  end

  def display_pos(pos)
    letter_hash = {
                    0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd', 4 => 'e',
                    5 => 'f', 6 => 'g', 7 => 'h', 8 => 'i', 9 => 'j'
                  }
    "row: #{letter_hash[pos[0]]}, col: #{pos[1] + 1}"
  end


end

BattleshipGame.new
