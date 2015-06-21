class System

  attr_reader :show_line, :strategy, :derivations

  def initialize reference
    @reference = reference
    @derivations = []
  end

  def add_derivation(statement, references, inference_rule)
    der = Derivation.new(statement, references, inference_rule)
    der.statement.nil? ? nil : @derivations << der
  end

  def add_show_line(string, strategy)
    @show_line = Statement.new(string)
    @strategy = strategy
  end

  def solved?
    derivations.any? { |d| d.statement.content == @show_line.content }
  end
  

end
