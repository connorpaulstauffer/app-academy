require 'byebug'

class HumanPlayer

  def initialize(game)
    @game = game
  end

  def get_guess
    guess = nil
    until @game.valid_guess?(guess)
      puts "Please enter a row: "
      row = gets.chomp.to_i
      puts "Please enter a column: "
      col = gets.chomp.to_i
      guess = [row, col]
    end
    guess
  end

  def receive_card_value(value)
  end
end

class ComputerPlayer

  def initialize(game)
    @game = game
    @overturned_value = ""
    @previous_position = []
    @card_locations = {}
    @paired_values = []
    setup_card_locations
  end

  def setup_card_locations
    ((0...@game.size).to_a * 2).permutation(2).to_a.uniq.each do |pos|
      @card_locations[pos] = nil
    end
  end

  def get_guess
    if !@overturned_value.empty?
      if match_exists?
        @previous_position = match_overturned
      elsif !unguessed_positions.empty?
        @previous_position = make_random_guess
      else
        @previous_position = choose_unpaired_value
      end
    else
      if !unguessed_positions.empty?
        @previous_position = make_random_guess
      else
        @previous_position = choose_unpaired_value
      end
    end
  end

  def match_exists?
    !@card_locations.select do |pos, val|
      pos != @previous_position && val == @overturned_value
    end.empty?
  end

  def match_overturned
    val = @card_locations.select do |pos, val|
      pos != @previous_position && val == @overturned_value
    end
    @paired_values << val.values.first
    val.keys.first
  end

  def make_random_guess
    sample = unguessed_positions.keys.sample
    @paired_values << sample if @overturned_value == @card_locations[sample]
    sample
  end

  def unguessed_positions
    @card_locations.select { |pos, val| val.nil? }
  end

  def choose_unpaired_value
    @card_locations.select do |pos, val|
      !@paired_values.include?(val)
    end.keys.first
  end

  def receive_card_value(value)
    @overturned_value = @overturned_value.empty? ? value : ""
    @card_locations[@previous_position] = value
  end

end
