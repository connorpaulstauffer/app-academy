class Derivation

  attr_reader :statement, :references, :inference_rule

  def initialize statement, references, inference_rule
    statement = Statement.new statement
    if derivation_valid? statement, references, inference_rule
      @statement = statement
      @references = references
      @inference_rule = inference_rule
    end
  end

  def derivation_valid? statement, references, inference_rule
    method = (inference_rule + '_valid?').to_sym
    Statement.new([]).send(method, statement, *references)
  end

  def inference_rule_symbol
    hash = {
             'and_in'          => '&I',   'and_out'          => '&O', 
             'or_in'           => 'vI',   'or_out'           => 'vO',
             'arrow_in'        => '->I',  'arrow_out'        => '->O',
             'double_in'       => '<->I', 'double_out'       => '<->O',
             'double_negation' => 'DN',   'contradiction_in' => 'X',
             'tilde_wedge_out' => '~vO',  'tilde_and_out'    => '~&O',
             'tilde_arrow_out' => '~->O', 'tilde_double_out' => '~<->O',
             'repetition'      => 'R'
           }
    hash[self.inference_rule]
  end

end
