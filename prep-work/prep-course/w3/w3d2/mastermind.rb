class Code

  attr_reader :pegs

  def initialize(pegs)
    @pegs = pegs
  end

  def self.random_pegs
    colors = [:red, :green, :blue, :yellow, :orange, :purple]
    pegs = Array.new(4) { colors.sample }
    Code.new(pegs)
  end

  def self.parse_string(string)
    color_hash = {
                  "R" => :red,    "G" => :green,  "B" => :blue,
                  "O" => :orange, "P" => :purple, "Y" => :yellow
                 }
    pegs = string.chars.map { |char| color_hash[char] }
    Code.new(pegs)
  end

  def [](index)
    @pegs[index]
  end

  def []=(index, mark)
    @pegs[index] = mark
  end

  def exact_matches(other)
    (0..3).select { |idx| self[idx] == other[idx] }
  end

  def near_matches(other)
    nil_self, nil_other = nilize_exact_matches(self, other)
    near_matches = []
    nil_self.pegs.each_with_index do |peg, idx|
      next if peg.nil?
      if nil_other.pegs.include?(peg)
        near_matches << idx
        nil_other[nil_other.pegs.index(peg)] = nil
      end
    end
    near_matches
  end

  def stringize_pegs
    color_hash = {
                  :red    => "R", :green  => "G", :blue   => "B",
                  :orange => "O", :purple => "P", :yellow => "Y"
                 }
    self.pegs.map { |peg| color_hash[peg] }.join("")
  end

  private

    def nilize_exact_matches(code1, code2)
      code1, code2 = Code.new(code1.pegs.dup), Code.new(code2.pegs.dup)
      code1.exact_matches(code2).each do |idx|
        code1[idx], code2[idx] = nil, nil
      end
      [code1, code2]
    end

end


class Game

  def initialize
    @turn_counter = 0
    @master = Code.random_pegs
  end

  def play
    introduce_game
    get_input
    until won? || lost?
      print_turn_results
      get_input
    end
    print_final_result
  end

  private

    def introduce_game
      puts "You're playing mastermind."
      puts """
      Input your guess as a sequence of capital letters, each corresponding to the
      first letter of a valid color. Ex: RBGY
      The valid colors are: red, green, blue, yellow, purple, orange
      """
    end

    def won?
      @master.pegs == @guess.pegs
    end

    def lost?
      @turn_counter >= 10
    end

    def get_input
      loop do
        print "\nPlease input your string: "
        input = gets.chomp.upcase
        break if process_input(input)
        puts "\nInvalid input. Try again."
      end
    end

    def process_input(input)
      valid = valid?(input)
      if valid
        @guess = Code.parse_string(input)
        @turn_counter += 1
      end
      valid
    end

    def valid?(input)
      return false unless input.length == 4
      input.chars.all? { |char| "RBGYPO".include?(char) }
    end

    def print_turn_results
      puts "\nYou've taken #{@turn_counter} turns."
      puts "Your exact matches were at indexes: #{printable_matches("exact")}"
      puts "Your near matches were at indexes: #{printable_matches("near")}"
    end

    def printable_matches(option)
      @guess.send("#{option}_matches", @master).map { |idx| idx + 1 }.join(', ')
    end

    def print_final_result
      print "\n#{win_lose_message} The answer is #{@master.stringize_pegs}.\n\n"
    end

    def win_lose_message
      won? ? "Congratulations, you win!" : "You took too many turns!"
    end

end

Game.new.play
