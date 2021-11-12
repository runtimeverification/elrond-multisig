require "protocol-correctness/lib/language/base-types.k"

module LIST-CONTAINS-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Bool ::= #listContainsSafe(ExpressionList, KItem)  [function]
endmodule

module LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Bool ::= #listContainsUnsafe(ExpressionList, KItem)  [function, functional]
endmodule

module LIST-CONTAINS
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-CONTAINS-SYNTAX
  imports K-EQUAL-SYNTAX

  rule #listContainsSafe(Es, E) => #listContainsUnsafe(Es, E)
    requires isKResult(Es) andBool isKResult(E)

  rule  #listContainsUnsafe([.], _) => false
  rule  #listContainsUnsafe([E:Expression, _:ExpressionCSV], E) => true
  rule  #listContainsUnsafe([_:Expression, Es:ExpressionCSV], X:KItem)
          => #listContainsUnsafe([Es], X)
    [owise]

endmodule
