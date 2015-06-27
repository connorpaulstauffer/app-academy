class Board

  def initialize(n)
    @grid = Array.new(n) {Array.new(n)}
  end

  def rows
    @grid
  end

  def cols
    @grid.transpose
  end

  def diag
  end  

end
