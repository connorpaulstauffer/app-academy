class Towers

  def initialize height = 3
    @towers = [build_tower(height), [], []]
    @height = height
  end

  def move from, to
    raise "Invalid move" unless valid? from, to
    @towers[to.to_i - 1] << @towers[from.to_i - 1].pop
  end

  def valid? from, to
    false if @towers[from.to_i - 1].empty?
    small_to_big = @towers[from.to_i - 1].last < (@towers[to.to_i - 1].last || 9999)
    different_tower = (from != to)
    false unless small_to_big && different_tower
    true
  end

  def won?
    @towers[1..2].any? { |tower| tower == build_tower(@height) }
  end

  def play
    while !self.won?
      towers
      puts "Move from? "
      from = gets.chomp
      puts "Move to? "
      to = gets.chomp
      self.move(from, to)
    end
    towers
    "Good job!"
  end

  def towers
    (@height - 1).downto(0) do |i|
      puts "#{@towers[0][i] || ' '} #{@towers[1][i] || ' '} #{@towers[2][i] || ' '}"
    end
  end

  private

    def build_tower height
      (1..height).to_a.reverse
    end

end
