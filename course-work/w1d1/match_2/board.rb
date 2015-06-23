class Board

  attr_reader :grid

  def initialize(size)
    @grid = Array.new(size) { Array.new(size) { Card.new } }
    @values = ('a'..'z').to_a.slice(0, ((size ** 2) / 2))
    populate
  end

  def populate
    values = @values + @values
    cards = values.shuffle
    @grid.flatten.each do |card|
      card.value = cards.pop
    end
  end

  def render
    output = @grid.map do |row|
               row.map do |element|
                 element.to_s
               end.join(" ")
             end.join("\n")
    #system("clear")
    puts "\n"
    puts output
  end

  def [](row, col)
    @grid[row][col]
  end

  def won?
    !@grid.flatten.any?{ |card| card.state == :hidden}
  end

  def reveal(guessed_pos)
    @grid[*guessed_pos].reveal
  end

end
