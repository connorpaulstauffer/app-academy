require "treetop"
Treetop.load 'grammar/statement_grammar'

class Statement

  attr_accessor :content

  def initialize content
    if content.class == String
      @content = parse content
    else
      @content = content
    end
    @content = clean @content
  end

  def stringize
    self.content.map do |el|
      if [Symbol, String].include?(el.class)
        el.to_s
      elsif el[0] == :~
        Statement.new(el).stringize
      else
        '(' + Statement.new(el).stringize + ')'
      end
    end.join(' ').gsub('~ ', '~')
  end

  def parse str
    StatementGrammarParser.new.parse(str.gsub(' ', '')).content
  end

  def clean arr
    arr = remove_double_brackets arr
    arr = remove_double_brackets_internal arr
    unwrap_atoms arr
  end

  def remove_double_brackets arr
    if (arr.length == 1) && (arr[0].class == Array)
      arr[0]
    elsif arr.any?{ |el| el.class == Array }
      arr.map do |el|
        if el.class == Array
          remove_double_brackets(el)
        else
          el
        end
      end
    else
      arr
    end
  end

  def remove_double_brackets_internal arr
    arr.map{ |el| (el.class == Array) ? remove_double_brackets(el) : el }
  end

  def unwrap_atoms arr
    arr.map do |el|
      if (el.class == Array)
        if (el.length == 1) && (el[0].class == String)
          el[0]
        else
          unwrap_atoms el
        end
      else
        el
      end
    end
  end

  def and_in arg1, arg2
    arr1 = []
    arr2 = []
    [arg1, arg2].each do |e|
      arr1 << e.content
      arr1 << :&
    end
    [arg2, arg1].each do |e|
      arr2 << e.content
      arr2 << :&
    end
    [Statement.new(arr1[0..-2]), Statement.new(arr2[0..-2])]
  end

  def and_in_valid? conclusion, arg1, arg2
    output = and_in(arg1, arg2)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def and_out statement
    return nil unless statement.content[1] == :&
    [Statement.new(statement.content[0]), Statement.new(statement.content[2])]
  end

  def and_out_valid? conclusion, arg
    output = and_out(arg)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def or_in arg, arb
    content = (arg.content.length > 1) ? arg.content : arg.content[0]
    arb_content = (arb.content.length > 1) ? arb.content : arb.content[0]
    [Statement.new([content, :v, arb_content]),Statement.new([arb_content, :v, content])]
  end

  def or_in_valid? conclusion, arg
    if (arg.content.length == 1) && (arg.content[0].class == String)
      arg_content = arg.content[0]
    else
      arg_content = arg.content
    end
    (conclusion.content[1] == :v) && conclusion.content.include?(arg_content)
  end

  def or_out arg1, arg2
    content = [arg1, arg2].map{ |arg| arg.content }
    negate_content = content.select{ |e| e[0] == :~ }
    or_content = content.select{ |e| e[1] == :v }
    return nil if negate_content.empty? || or_content.empty?
    negate_value = negate_content[0][1]
    or_values = [or_content[0][0], or_content[0][2]]
    [Statement.new(or_values.select{ |val| val != negate_value }[0])]
  end

  def or_out_valid? conclusion, arg1, arg2
    output = or_out(arg1, arg2)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def double_in arg1, arg2
    content1, content2 = arg1.content, arg2.content
    correct_content = (content1[0] == content2[2]) && (content1[2] == content2[0])
    correct_operator = (content1[1] == :'->') && (content2[1] == :'->')
    return nil unless correct_content && correct_operator
    [Statement.new([content1[0], :'<->', content1[2]]), Statement.new([content1[2], :'<->', content1[0]])]
  end

  def double_in_valid? conclusion, arg1, arg2
    output = double_in(arg1, arg2)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def double_out arg
    content = arg.content
    return nil unless content[1] == :'<->'
    [Statement.new([content[0], :'->', content[2]]), Statement.new([content[2], :'->', content[0]])]
  end

  def double_out_valid? conclusion, arg
    output = double_out(arg)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def arrow_out arg1, arg2
    content1, content2 = arg1.content, arg2.content
    arrow_content = [content1, content2].select{ |s| s[1] == :'->' }
    simple_content = [content1, content2].select{ |s| s != arrow_content[0] }
    return nil if arrow_content.empty? || simple_content.empty?
    arrow_content, simple_content = arrow_content[0], simple_content[0]
    simple_content = simple_content[0] if (simple_content[0].class == String) && (simple_content.length == 1)
    if arrow_content[0] == simple_content
      return [Statement.new([arrow_content[2]])]
    elsif (simple_content[0] == :~) && (simple_content[1] == arrow_content[2])
      return [Statement.new([:~, arrow_content[0]])]
    else
      return nil
    end
  end

  def arrow_out_valid? conclusion, arg1, arg2
    output = arrow_out(arg1, arg2)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def double_negation arg
    content = arg.content
    if (content[0] == :~) && (content[1][0] == :~)
      return [Statement.new(content[1][1])]
    elsif content[0].class == String
      return [Statement.new([:~, [:~, content]])]
    else
      return nil
    end
  end

  def double_negation_valid? conclusion, arg
    output = double_negation(arg)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def contradiction_in arg1, arg2
    content1, content2 = arg1.content, arg2.content
    if content2.include?(content1) || (content2.include?(content1[0]) && content1[0].class == String)
      simple_content = content1
      negate_content = content2
    end
    if content1.include?(content2) || (content1.include?(content2[0]) && content2[0].class == String)
      simple_content = content2
      negate_content = content1
    end
    return nil if simple_content.nil? || negate_content.nil?
    simple_content = simple_content[0] if simple_content.length == 1
    if (negate_content[0] == :~) && (negate_content[1] == simple_content)
      return [Statement.new([:X])]
    else
      return nil
    end
  end

  def contradiction_in_valid? conclusion, arg1, arg2
    output = contradiction_in(arg1, arg2)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def tilde_wedge_out arg
    content = arg.content
    if (content[0] == :~) && (content[1][1] == :v)
      return [content[1][0], content[1][2]].map do |c|
                 Statement.new([:~, c])
             end
    else
      return nil
    end
  end

  def tilde_wedge_out_valid? conclusion, arg
    output = tilde_wedge_out(arg)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def tilde_and_out arg
    content = arg.content
    if (content[0] == :~) && (content[1][1] == :&)
      val1 = content[1][0]
      val2 = content[1][2]
      return [Statement.new([val1, :'->', [:~, val2]]), Statement.new([val2, :'->', [:~, val1]])]
    else
      return nil
    end
  end

  def tilde_and_out_valid? conclusion, arg
    output = tilde_and_out(arg)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def tilde_arrow_out arg
    content = arg.content
    if (content[0] == :~) && (content[1][1] == :'->')
      val1 = content[1][0]
      val2 = content[1][2]
      return [Statement.new([val1, :& , [:~, val2]])]
    else
      return nil
    end
  end

  def tilde_arrow_out_valid? conclusion, arg
    output = tilde_arrow_out(arg)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def tilde_double_out arg
    content = arg.content
    if (content[0] == :~) && (content[1][1] == :'<->')
      val1 = content[1][0]
      val2 = content[1][2]
      return [
              Statement.new([[:~, val1], :'<->', val2]),
              Statement.new([[:~, val2], :'<->', val1]),
              Statement.new([val1, :'<->', [:~, val2]]),
              Statement.new([val2, :'<->', [:~, val1]])
             ]
    else
      return nil
    end
  end

  def tilde_double_out_valid? conclusion, arg
    output = tilde_double_out(arg)
    return false if output.nil?
    output.any?{ |s| s.content == conclusion.content }
  end

  def repetition arg
    return [Statement.new(arg.content)]
  end

  def repetition_valid? conclusion, arg
    conclusion.content == arg.content
  end

end
