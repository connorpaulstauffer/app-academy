load 'lib/proof.rb'

proof = Proof.new
proof.add_premises('A -> B', 'A')
proof.add_show_line('B', :DD)
proof.system.add_derivation('B', [proof.statement_by_line(1), proof.statement_by_line(2)], 'arrow_out')

proof.print
#p proof.lines
p proof.solved?
