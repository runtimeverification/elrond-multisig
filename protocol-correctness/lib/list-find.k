require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/add-one-if-not-negative.k"

module LIST-FIND-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Int ::= #listFind(ExpressionList, Expression)  [function, functional]

endmodule

module LIST-FIND
  imports LIST-FIND-SYNTAX

  imports ADD-ONE-IF-NOT-NEGATIVE-SYNTAX

  rule  #listFind([.], _:Expression) => -1
  rule  #listFind([X:Expression, _:ExpressionCSV], X) => 0
  rule  #listFind([E:Expression, Es:ExpressionCSV], X:Expression) => addOneIfNotNegative(#listFind([Es], X))
    requires isKResult(E) andBool isKResult(X)
    [owise]

endmodule
