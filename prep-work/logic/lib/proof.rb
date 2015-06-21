load 'lib/derivation.rb'
load 'lib/statement.rb'
load 'lib/system.rb'

class Proof

  attr_accessor :system
  attr_reader :premises

  def initialize
    @premises = []
    @system = System.new(self)
  end

  def add_premises(*strings)
    strings.each { |str| @premises << Statement.new(str) }
  end

  def add_show_line(string, strategy)
    @system.add_show_line(string, strategy)
  end

  def statement_by_line(line)
    self.lines[line][:statement]
  end

  def line_by_statement(statement)
    lines.each { |line, hash| return line if hash[:statement] == statement }
  end

  def solved?
    @system.solved?
  end

  def lines
    @lines = {}
    i = 1
    @premises.each do |pr|
      @lines[i] = {statement: pr, type: 'premise'}
      i += 1
    end
    if !self.system.show_line.nil?
      @lines[i] = {statement: self.system.show_line, strategy: self.system.strategy, type: 'show'}
    end
    if !self.system.derivations.empty?
    i += 1
      self.system.derivations.each do |der|
        @lines[i] = { statement: der.statement,
                      type: 'derivation',
                      refs: der.references,
                      rule: der.inference_rule_symbol
                    }
        i += 1
      end
    end
    @lines
  end

  def print
    line_hash = self.lines
    line_hash.keys.sort.each do |line|
      arr = [(line.to_s + ')')]
      if line_hash[line][:type] == 'show'
        arr << 'Show: ' + line_hash[line][:statement].stringize
        arr << line_hash[line][:strategy].to_s
      elsif line_hash[line][:type] == 'premise'
        arr << line_hash[line][:statement].stringize
        arr << 'Pr'
      else
        arr << line_hash[line][:statement].stringize
        line_refs = line_hash[line][:refs].map do |ref|
                      line_by_statement(ref)
                    end.join(',')
        arr <<  "#{line_refs} #{line_hash[line][:rule]}"
      end
      puts sprintf("%-4<line>s %-30<stat>s %-<info>s", { line: arr[0], stat: arr[1], info: arr[2] })
    end
    nil
  end


end
