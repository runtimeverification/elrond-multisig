require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"

module LIST-TO-MAP-SET-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports MAP

  syntax Map ::= listToMapSet(ExpressionList)  [function, functional]
endmodule

module LIST-TO-MAP-SET
  imports LIST-TO-MAP-SET-REFLECTION
  imports LIST-TO-MAP-SET-SYNTAX

  rule listToMapSet([.]) => .Map
  rule listToMapSet([E, Es]) => listToMapSet([Es])[E <- 0]
endmodule

module LIST-TO-MAP-SET-REFLECTION
  imports LIST-TO-MAP-SET-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply($listToMapSet, reflectionArgument(Es:ExpressionList))
      => listToMapSet(Es)
  rule reflectionApply($listToMapSet, reflectionArgument(Es:ExpressionCSV))
      => listToMapSet([Es])
endmodule
