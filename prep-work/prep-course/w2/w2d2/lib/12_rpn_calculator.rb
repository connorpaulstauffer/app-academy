class RPNCalculator

  attr_accessor :numbers

  def initialize
    @numbers = []
    @operator_hash = { plus: :+, minus: :-, times: :*, divide: :/ }
  end

  def value
    value = @numbers.last
    value % 1 == 0 ? value.to_i : value
  end

  def push(number)
    @numbers << number
  end

  def method_missing(symbol)
    enough?
    num1, num2 = @numbers.pop(2)
    symbol = @operator_hash[symbol] unless is_operator?(symbol)
    @numbers << num1.send(symbol, num2.to_f)
  end

  def tokens(string)
    string.split(' ').map { |el| is_operator?(el) ? el.to_sym : el.to_i }
  end

  def evaluate(string)
    tokens(string).each do |element|
      element.class == Symbol ? method_missing(element) : push(element)
    end
    value
  end

  private

    def enough?
      raise "calculator is empty" if @numbers.length == 0
      raise "calculator does not have enough values" if @numbers.length < 2
    end

    def is_operator?(element)
      element = element.to_s if element.class == Symbol
      element =~ /[\+\-\*\/]/
    end

end


def interpret_invocation
  if ARGV.first.nil?
    prompt_user
  else
    content = File.read(ARGV.first)
    puts RPNCalculator.new.evaluate(content)
  end
end

def prompt_user
  input = gets.chomp
  values = []
  until input == ""
    values << input
    input = gets.chomp
  end
  puts RPNCalculator.new.evaluate(values.join(' '))
end

if __FILE__ == $PROGRAM_NAME
  interpret_invocation
end
