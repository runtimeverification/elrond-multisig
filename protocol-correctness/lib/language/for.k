require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/running-syntax.k"

module FOR
  imports BASE-TYPES-SYNTAX
  imports RUNNING-SYNTAX

  syntax Instruction ::= "for" "(" indexVar:Variable "=" value:Usize "," valueVar:Variable ")" "in" ExpressionList Block

  context runInstruction(for(_:Variable, _:Variable) in {HOLE:Expression => evaluate(HOLE)}:>Expression _:Block)
  rule runInstruction(for(Index:Variable, Value:Variable) in (L:ExpressionList) B:Block)
        => runInstruction(for(Index = u(0), Value) in L B)
    requires isKResult(L)

  rule runInstruction(for(_:Variable = _:Usize, _:Variable) in [.] _:Block)
        => evaluate(void)
    [label(forEnd)]
  rule runInstruction(
          for (IndexVar:Variable = u(Index:Int), ValueVar:Variable)
              in [E:Expression, Es:ExpressionCSV]
              {B:Instructions}
        )
        =>  runPseudoCode(IndexVar = u(Index); ValueVar = E; B)
            ~> runInstruction(for(IndexVar = u(Index +Int 1), ValueVar) in [Es:ExpressionCSV] {B})
    [label(forLoop)]
endmodule
