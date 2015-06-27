
require "colorize"

class Tile

  attr_reader :value

  def initialize(value)
    if value.to_i == 0
      @value = nil
      @given = false
    else
      @value = value.to_i
      @given = true
    end
  end

  def given?
    @given
  end

  def value=(input)
    return nil if given?
    @value = input
  end

  def to_s
    if @given
      @value.to_s.red
    else
      @value ? @value.to_s : "0"
    end
  end

end
