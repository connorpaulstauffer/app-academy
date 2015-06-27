require "./player.rb"
require 'set'

class GhostGame
  attr_reader :fragment

  def initialize(players)
    @fragment = ""
    setup_dictionary
    @players = players
    @player_index = 0
  end

  def setup_dictionary
    @dictionary = Set.new
    File.readlines('dictionary.txt').each do |word|
      @dictionary << word.chomp
    end
  end

  def round_over?
    @dictionary.include?(@fragment)
  end

  def ask_about_game_mode
    puts "Do you want to play SuperGhost?(y/n)"
    input = 'y' #gets.chomp
    if input == 'y'
      @players.each { |player| player.tell_ghost_mode }
    end
  end

  def play
    ask_about_game_mode
    until over?
      show_ghost_counters
      sleep(1)
      play_round
      @current_player.increment_ghost_counter
      setup_dictionary
      @fragment = ""
    end
    puts "#{@current_player.name} lost."
    @players.delete(@current_player)
    @player_index = 0
    if @players.length > 1 then
      play
    else
      puts "player #{@players[0].name} has won"
    end
    @players[0].name
  end

  def over?
    @players.any? { |player| player.ghost_counter.length == 5 }
  end

  def play_turn
    system("clear")
    puts "Current fragment is: #{@fragment}"
    sleep(0.5)
    tell_players
    loop do
      input, front, flip = @current_player.get_input
      if valid_input?(input, front, flip)
        @fragment.reverse if flip
        if front
          @fragment = input + @fragment
        else
          @fragment << input
        end
        #update_dictionary
        break
      end
      puts "Invalid input"
    end
  end

  def tell_players
    @players.each do |player|
      player.get_fragment(@fragment)
      player.get_player_count(@players.length)
    end
  end


  def play_round
    until round_over?
      @current_player = @players[@player_index]
      play_turn
      @player_index = (@player_index + 1) % @players.length
    end
    puts "#{@fragment} is a word."
    sleep(1)
  end

  def show_ghost_counters
    puts @players.map {|player| "#{player.name}: #{player.ghost_counter}"}.join("\n")
  end

  def valid_input?(input, front, flip)
    if front
      if flip
        @dictionary.any? {|word| word.include?(input+@fragment.reverse)}
      else
        @dictionary.any? {|word| word.include?(input+@fragment)}
      end
    else
      if flip
        @dictionary.any? {|word| word.include?(@fragment.reverse + input)}
      else
        @dictionary.any? {|word| word.include?(@fragment + input)}
      end
    end
  end

=begin
  def update_dictionary
    @dictionary.select! {|word| start_is?(word, @fragment)}
  end
=end

  def start_is?(word, start)
    word[0...start.length] == start
  end

end




p1 = AiPlayer.new("Emily")
p2 = AiPlayer.new("Connor")
game = GhostGame.new([p1, p2])
game.play
