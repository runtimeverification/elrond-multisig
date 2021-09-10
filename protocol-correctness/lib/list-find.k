require "protocol-correctness/lib/add-one-if-not-negative.k"
require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/reflection.k"

module LIST-FIND-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Int ::= #listFindSafe(ExpressionList, Expression)  [function, functional]

endmodule

module LIST-FIND-ADDITIONAL-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Int ::= #listFindUnsafe(ExpressionList, Expression)  [function, functional]

endmodule

module LIST-FIND
  imports LIST-FIND-REFLECTION
  imports LIST-FIND-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX

  imports ADD-ONE-IF-NOT-NEGATIVE-SYNTAX

  rule #listFindSafe(Es:ExpressionList, E:Expression) => #listFindUnsafe(Es, E)
    requires isKResult(E) andBool isKResult(Es)

  rule  #listFindUnsafe([.], _:Expression) => -1
  rule  #listFindUnsafe([X:Expression, _:ExpressionCSV], X) => 0
  rule  #listFindUnsafe([E:Expression, Es:ExpressionCSV], X:Expression)
      => addOneIfNotNegative(#listFindUnsafe([Es], X))
    [owise]

endmodule

module LIST-FIND-REFLECTION
  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-FIND-SYNTAX
  imports REFLECTION-SYNTAX

  rule reflectionApply($#listFindUnsafe,
          (reflectionArgument(Es:ExpressionCSV), reflectionArgument(E:Expression))
      )
      => #listFindUnsafe([Es], E)
endmodule
