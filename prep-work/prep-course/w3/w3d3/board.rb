require 'command_line_reporter'

class Board

  include CommandLineReporter

  def initialize
    @grid = Array.new(10) { Array.new(10) }
    @targets = []
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end

  def setup_ships
    [AircraftCarrier, Battleship, Submarine, Destroyer, PatrolBoat].each do |b|
      loop do
        break if add_target(b.new(@boat))
      end
    end
  end

  def add_target(boat)
    return false if collision?(boat)
    @targets << boat
    boat.positions.each { |pos| self[*pos] = boat }
  end

  def collision?(boat)
    boat.positions.any? { |pos| !self[*pos].nil? }
  end

  def attack(pos)
    if self[*pos].class.superclass == Piece
       self[*pos].attack(pos)
       return self[*pos]
    else
      self[*pos] = :X
    end
  end

  def all_targets_sunk?
    @targets.all? { |target| target.sunk? }
  end

  def open_positions
    coordinates.select { |pos| un_hit_piece?(pos) || empty?(pos) }
  end

  def coordinates
    coordinates = []
    0.upto(9) { |row| 0.upto(9) { |col| coordinates << [row, col] } }
    coordinates
  end

  def un_hit_piece?(pos)
    self[*pos].class.superclass == Piece && !self[*pos].hit?(pos)
  end

  def hit_piece?(pos)
    self[*pos].class.superclass == Piece && self[*pos].hit?(pos)
  end

  def empty?(pos)
    self[*pos].nil?
  end

  def display(for_opponent)
    table(border: true) do
      header_row
      10.times { |row_idx| display_row(row_idx, for_opponent) }
    end
  end

  def header_row
    row do
      column("", width: 3, align: 'center')
      10.times { |idx| column("#{idx + 1}", width: 3, align: 'center') }
    end
  end

  private

    def display_row(row_idx, for_opponent)
      row do
        letter_hash = {
                        0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd', 4 => 'e',
                        5 => 'f', 6 => 'g', 7 => 'h', 8 => 'i', 9 => 'j'
                      }
        column("#{letter_hash[row_idx]}", width: 3, align: 'center')
        10.times { |col_idx| display_element(row_idx, col_idx, for_opponent) }
      end
    end

    def display_element(row_idx, col_idx, for_opponent)
      column(stringize(row_idx, col_idx, for_opponent), width: 3, align: 'center', color: determine_color(row_idx, col_idx))
    end

    def determine_color(row_idx, col_idx)
      value = self[row_idx, col_idx]
      if value.class.superclass == Piece
        value.hit?([row_idx, col_idx]) ? "red" : "green"
      else
        "white"
      end
    end

    def stringize(row_idx, col_idx, for_opponent)
      value = self[row_idx, col_idx]
      if value.nil?
        ""
      elsif value == :X
        "X"
      else
        value.stringize([row_idx, col_idx], for_opponent)
      end
    end

end
