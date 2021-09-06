require "protocol-correctness/lib/language/base-types.k"

module LIST-CONTAINS-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Bool ::= #listContains(ExpressionList, KItem)  [function, functional]

endmodule

module LIST-CONTAINS
  imports LIST-CONTAINS-SYNTAX
  imports K-EQUAL

  rule  #listContains([.], _) => false
  // rule  #listContains([E1:Expression, Es:ExpressionCSV], E2) => E1 ==K E2 orBool #listContains([Es], E2)
  rule  #listContains([E:Expression, _:ExpressionCSV], E) => true
  rule  #listContains([_:Expression, Es:ExpressionCSV], X:KItem)
          => #listContains([Es], X)  [owise]

endmodule
