require 'byebug'

class RockPaperScissorsGame

  def initialize(move)
    @valid_moves = %w(Rock Paper Scissors)
    set_player_move(move)
    generate_computer_move
  end

  def play
    "#{@computer_move}, #{determine_outcome}"
  end

  private

    def generate_computer_move
      @computer_move = @valid_moves.sample
    end

    def set_player_move move
      raise "Invalid move" unless @valid_moves.include?(move)
      @player_move = move
    end

    def determine_outcome
      return "Draw" if @player_move == @computer_move
      non_draw_outcome
    end

    def non_draw_outcome
      case @player_move
      when "Rock"
        @computer_move == "Paper" ? "Lose" : "Win"
      when "Paper"
        @computer_move == "Scissors" ? "Lose" : "Win"
      else
        @computer_move == "Rock" ? "Lose" : "Win"
      end
    end

end

def rps(move)
  RockPaperScissorsGame.new(move).play
end


class Remixer

  def initialize(ingredient_pairs)
    @alcohols = ingredient_pairs.map(&:first)
    @mixers = ingredient_pairs.map(&:last)
  end

  def remix
    @mixers.shuffle.map.with_index { |mixer, idx| [@alcohols[idx], mixer] }
  end

  def remix_unique
    mixers = @mixers.dup
    last_mixer = mixers.pop
    last_mixer_index = rand(@alcohols.length - 1)
    mixers.shuffle!
    @alcohols.map.with_index do |alcohol, idx|
      if idx == last_mixer_index
        [alcohol, last_mixer]
      elsif @mixers[idx] == mixers.last
        [alcohol, mixers.shift]
      else
        [alcohol, mixers.pop]
      end
    end
  end

end


def remix ingredient_pairs
  Remixer.new(ingredient_pairs).remix
end

def remix_unique ingredient_pairs
  Remixer.new(ingredient_pairs).remix_unique
end
