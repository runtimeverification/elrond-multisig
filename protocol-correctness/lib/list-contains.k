require "protocol-correctness/lib/base-types.k"

module LIST-CONTAINS-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Bool ::= #listContains(ExpressionList, KItem)  [function, functional]

endmodule

module LIST-CONTAINS
  imports LIST-CONTAINS-SYNTAX

  rule  #listContains([.], _) => false
  rule  #listContains([E:Expression, _:ExpressionCSV], E) => true
  rule  #listContains([_:Expression, Es:ExpressionCSV], X:KItem)
          => #listContains([Es], X)  [owise]

endmodule
