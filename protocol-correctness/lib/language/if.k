require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/running-syntax.k"

module IF
  imports BASE-TYPES-SYNTAX
  imports RUNNING-SYNTAX

  context runInstruction(if({HOLE:Expression => evaluate(HOLE)}:>Expression) _:Block)
  context runInstruction(if({HOLE:Expression => evaluate(HOLE)}:>Expression) _:Block else _:Block)

  rule runInstruction(if(true) {Is:Instructions}) => runPseudoCode(Is)
  rule runInstruction(if(false) _:Block) => evaluate(void)

  rule runInstruction(if(true) {Is:Instructions} else _:Block) => runPseudoCode(Is)
  rule runInstruction(if(false) _:Block else {Is:Instructions}) => runPseudoCode(Is)
endmodule
