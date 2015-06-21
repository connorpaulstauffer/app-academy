class Towers

  def initialize(height = 3)
    @stacks = [build_stack(height), [], []]
  end

  def valid?(from, to)
    return false if [from, to].any? { |e| @stacks[e].nil? } || @stacks[from].empty?
    @stacks[to].empty? || @stacks[from].last < @stacks[to].last
  end

  def move(from, to)
    return false if !valid?(from, to)
    from_last = @stacks[from]
    @stacks[to] << @stacks[from].pop
  end

  def won?
    @stacks[0].empty? && @stacks[1..2].any?(&:empty?)
  end

  def run_game
    until won?
      display
      prompt
    end
    puts "Congratulations! You won."
  end

  def display
    2.downto(0) do |i|
      puts "#{@stacks[0][i] || " "}  #{@stacks[1][i] || " "}  #{@stacks[2][i] || " "}\n"
    end
  end

  def prompt
    puts "Move from: "
    from = gets.to_i - 1
    puts "Move to: "
    to = gets.to_i - 1
    puts "Invalid move" if move(from, to) == false
  end

  private

    def build_stack(num)
      (1..num).to_a.reverse
    end

end
