class Card
  attr_accessor :value, :state

  def initialize
    @state = :hidden
  end

  def hide
    @state = :hidden
  end

  def reveal
    @state = :revealed
  end

  def to_s
    @state == :revealed ? @value : '*'
  end

  def ==(other_card)
    @value == other_card.value
  end
end
