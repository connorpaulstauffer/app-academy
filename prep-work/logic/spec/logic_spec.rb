require 'derivation'
require 'proof'
require 'show-line'
require 'statement'
require 'system'


describe Statement do

  before :all do
    @class = Statement.new 'Y'
    @contradiction = Statement.new [:X]
    @content_one     = 'A'
    @content_two     = 'A & B'
    @content_three   = 'A v (B -> C)'
    @content_four    = '(B v C) & (A -> (D -> B))'
    @content_five    = '~A'
    @content_six     = '~(A & B)'
    @content_seven   = '~A -> B'
    @content_eight   = '~(B v C) & ~(~A -> (D -> ~B))'
    @content_nine    = '~~A'
    @content_ten     = '~~~(B & C)'
    @statement_one   = Statement.new 'A'
    @statement_two   = Statement.new 'B'
    @statement_three = Statement.new 'A & B'
    @statement_four  = Statement.new 'A v (B -> C)'
    @statement_five  = Statement.new '~(A & B)'
    @statement_six   = Statement.new '(A & B) & (A v (B -> C))'
    @statement_seven = Statement.new 'A v B'
    @statement_eight = Statement.new '(A v B) v ~(A & B)'
    @statement_nine  = Statement.new '~A'
    @statement_ten   = Statement.new '(A v (B -> C)) v (A & B)'
    @statement_eleven = Statement.new 'A -> B'
    @statement_twelve = Statement.new 'B -> A'
    @statement_thirteen = Statement.new 'A <-> B'
    @statement_fourteen = Statement.new '~(A v B) -> (C & D)'
    @statement_fifteen = Statement.new '(C & D) -> ~(A v B)'
    @statement_sixteen = Statement.new '(C & D) <-> ~(A v B)'
    @statement_seventeen = Statement.new '~B'
    @statement_eighteen = Statement.new '~(C & D)'
    @statement_nineteen = Statement.new '~~(A v B)'
    @statement_twenty = Statement.new '~~A'
    @statement_twenty_one = Statement.new '~(A v B)'
    @statement_twenty_two = Statement.new '~(~(A v B) v (A & B))'
    @statement_twenty_three = Statement.new 'A -> ~B'
    @statement_twenty_four = Statement.new 'B -> ~A'
    @statement_twenty_five = Statement.new '~(~(A v B) & (C & D))'
    @statement_twenty_six = Statement.new '~(A v B) -> ~(C & D)'
    @statement_twenty_seven = Statement.new '(C & D) -> ~~(A v B)'
    @statement_twenty_eight = Statement.new '~(A -> B)'
    @statement_twenty_nine = Statement.new 'A & ~B'
    @statement_thirty = Statement.new '~(C -> (A v B))'
    @statement_thirty_one = Statement.new 'C & ~(A v B)'
    @statement_thirty_two = Statement.new '~(A <-> B)'
    @statement_thirty_three = Statement.new '~A <-> B'
    @statement_thirty_four = Statement.new '~B <-> A'
    @statement_thirty_five = Statement.new 'A <-> ~B'
    @statement_thirty_six = Statement.new 'B <-> ~A'
    @statement_thirty_seven = Statement.new '~((B v C) <-> ~A)'
    @statement_thirty_eight = Statement.new '(B v C) <-> ~~A'
  end

  describe "#parse" do

    it "handles single symbol statements" do
      expect(@class.parse(@content_one)).to eq(['A'])
    end

    it "handles basic molecular statements" do
      expect(@class.parse(@content_two)).to eq(['A', :&, 'B'])
    end

    it "handles more complex molecular statements" do
      expect(@class.parse(@content_three)).to eq(['A', :v, ['B', :'->', 'C']])
      expect(@class.parse(@content_four)).to eq([['B', :v, 'C'], :&, ['A', :'->', ['D', :'->', 'B']]])
    end

    it "handles statements with negations" do
      expect(@class.parse(@content_five)).to eq([[:~, 'A']])
      expect(@class.parse(@content_six)).to eq([[:~, ['A', :&, 'B']]])
      expect(@class.parse(@content_seven)).to eq([[:~, 'A'], :'->', 'B'])
      expect(@class.parse(@content_eight)).to eq([[:~, ['B', :v, 'C']], :&, [:~, [[:~, 'A'], :'->', ['D', :'->', [:~, 'B']]]]])
    end

    it "handles statements with multiple negations" do
      expect(@class.parse(@content_nine)).to eq([[:~, [:~, 'A']]])
      expect(@class.parse(@content_ten)).to eq([[:~, [:~, [:~, ['B', :&, 'C']]]]])
    end

  end

  describe "#stringize" do

    it "handles simple cases" do
      expect(@statement_one.stringize).to eq('A')
      expect(@statement_three.stringize).to eq('A & B')
      expect(@statement_twelve.stringize).to eq('B -> A')
    end

    it "handles negations" do
      expect(@statement_nine.stringize).to eq('~A')
      expect(@statement_five.stringize).to eq('~(A & B)')
    end

    it "handles complex cases" do
      expect(@statement_twenty_five.stringize).to eq('~(~(A v B) & (C & D))')
      expect(@statement_thirty_eight.stringize).to eq('(B v C) <-> ~~A')
    end

  end

  describe "#and_in" do

    it "handles simple valid cases" do
      expect(@class.and_in_valid?(@statement_three, @statement_one, @statement_two)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.and_in_valid?(@statement_six, @statement_three, @statement_four)).to be true
    end

    it "handles invalid cases" do
      expect(@class.and_in_valid?(@statement_four, @statement_one, @statement_two)).to be false
    end

  end

  describe "#and_out" do

    it "handles simple valid cases" do
      expect(@class.and_out_valid?(@statement_one, @statement_three)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.and_out_valid?(@statement_four, @statement_six)).to be true
    end

    it "handles invalid cases" do
      expect(@class.and_out_valid?(@statement_four, @statement_one)).to be false
    end

  end

  describe "#or_in" do

    it "handles simple valid cases" do
      expect(@class.or_in_valid?(@statement_seven, @statement_one)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.or_in_valid?(@statement_eight, @statement_five)).to be true
    end

    it "handles invalid cases" do
      expect(@class.or_in_valid?(@statement_eight, @statement_one)).to be false
    end

  end

  describe "#or_out" do

    it "handles simple valid cases" do
      expect(@class.or_out_valid?(@statement_one, @statement_seventeen, @statement_seven)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.or_out_valid?(@statement_four, @statement_ten, @statement_five)).to be true
    end

    it "handles invalid cases" do
      expect(@class.or_out_valid?(@statement_four, @statement_ten, @statement_three)).to be false
    end

  end

  describe "#double_in" do

    it "handles simple valid cases" do
      expect(@class.double_in_valid?(@statement_thirteen, @statement_eleven, @statement_twelve)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.double_in_valid?(@statement_sixteen, @statement_fourteen, @statement_fifteen)).to be true
    end

    it "handles invalid cases" do
      expect(@class.double_in_valid?(@statement_sixteen, @statement_fourteen, @statement_five)).to be false
    end

  end

  describe "#double_out" do

    it "handles simple valid cases" do
      expect(@class.double_out_valid?( @statement_eleven, @statement_thirteen)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.double_out_valid?(@statement_fourteen, @statement_sixteen)).to be true
    end

    it "handles invalid cases" do
      expect(@class.double_out_valid?(@statement_fourteen, @statement_five)).to be false
    end

  end

  describe "#arrow_out" do

    it "handles simple valid cases" do
      expect(@class.arrow_out_valid?( @statement_two, @statement_eleven, @statement_one)).to be true
      expect(@class.arrow_out_valid?( @statement_seventeen, @statement_nine, @statement_twelve)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.arrow_out_valid?(@statement_eighteen, @statement_nineteen, @statement_fifteen)).to be true
    end

    it "handles invalid cases" do
      expect(@class.arrow_out_valid?(@statement_nineteen, @statement_eighteen, @statement_five)).to be false
    end

  end

  describe "#double_negation" do

    it "handles simple valid cases" do
      expect(@class.double_negation_valid?( @statement_twenty, @statement_one)).to be true
      expect(@class.double_negation_valid?( @statement_one, @statement_twenty)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.double_negation_valid?( @statement_nineteen, @statement_seven)).to be true
      expect(@class.double_negation_valid?( @statement_seven, @statement_nineteen)).to be true
    end

    it "handles invalid cases" do
      expect(@class.double_negation_valid?( @statement_two, @statement_one)).to be false
    end

  end

  describe "#contradiction_in" do

    it "handles simple valid cases" do
      expect(@class.contradiction_in_valid?(@contradiction, @statement_one, @statement_nine)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.contradiction_in_valid?(@contradiction, @statement_nine, @statement_twenty)).to be true
      expect(@class.contradiction_in_valid?(@contradiction, @statement_three, @statement_five)).to be true
    end

    it "handles invalid cases" do
      expect(@class.contradiction_in_valid?(@contradiction, @statement_five, @statement_seven)).to be false
    end

  end

  describe "#tilde_wedge_out" do

    it "handles simple valid cases" do
      expect(@class.tilde_wedge_out_valid?(@statement_nine, @statement_twenty_one)).to be true
      expect(@class.tilde_wedge_out_valid?(@statement_seventeen, @statement_twenty_one)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.tilde_wedge_out_valid?(@statement_five, @statement_twenty_two)).to be true
      expect(@class.tilde_wedge_out_valid?(@statement_nineteen, @statement_twenty_two)).to be true
    end

    it "handles invalid cases" do
      expect(@class.tilde_wedge_out_valid?(@statement_nineteen, @statement_one)).to be false
    end

  end

  describe "#tilde_and_out" do

    it "handles simple valid cases" do
      expect(@class.tilde_and_out_valid?(@statement_twenty_three, @statement_five)).to be true
      expect(@class.tilde_and_out_valid?(@statement_twenty_four, @statement_five)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.tilde_and_out_valid?(@statement_twenty_six, @statement_twenty_five)).to be true
      expect(@class.tilde_and_out_valid?(@statement_twenty_seven, @statement_twenty_five)).to be true
    end

    it "handles invalid cases" do
      expect(@class.tilde_and_out_valid?(@statement_six, @statement_one)).to be false
    end

  end

  describe "#tilde_arrow_out" do

    it "handles simple valid cases" do
      expect(@class.tilde_arrow_out_valid?(@statement_twenty_nine, @statement_twenty_eight)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.tilde_arrow_out_valid?(@statement_thirty_one, @statement_thirty)).to be true
    end

    it "handles invalid cases" do
      expect(@class.tilde_arrow_out_valid?(@statement_six, @statement_one)).to be false
    end

  end

  describe "#tilde_double_out" do

    it "handles simple valid cases" do
      expect(@class.tilde_double_out_valid?(@statement_thirty_three, @statement_thirty_two)).to be true
      expect(@class.tilde_double_out_valid?(@statement_thirty_four, @statement_thirty_two)).to be true
      expect(@class.tilde_double_out_valid?(@statement_thirty_five, @statement_thirty_two)).to be true
      expect(@class.tilde_double_out_valid?(@statement_thirty_six, @statement_thirty_two)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.tilde_double_out_valid?(@statement_thirty_eight, @statement_thirty_seven)).to be true
    end

    it "handles invalid cases" do
      expect(@class.tilde_double_out_valid?(@statement_thirty_eight, @statement_thirty)).to be false
    end

  end

  describe "#repetition" do

    it "handles simple valid cases" do
      expect(@class.repetition(@statement_one)[0].content).to eq(@statement_one.content)
      expect(@class.repetition_valid?(@statement_two, @statement_two)).to be true
    end

    it "handles complex valid cases" do
      expect(@class.repetition(@statement_twenty_nine)[0].content).to eq(@statement_twenty_nine.content)
      expect(@class.repetition_valid?(@statement_thirty_eight, @statement_thirty_eight)).to be true
    end

    it "handles invalid cases" do
      expect(@class.repetition(@statement_twenty_nine)[0].content).to_not eq(@statement_thirty.content)
      expect(@class.repetition_valid?(@statement_thirty_eight, @statement_thirty_seven)).to be false
    end

  end

end
