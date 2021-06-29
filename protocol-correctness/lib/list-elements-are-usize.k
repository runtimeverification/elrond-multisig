require "protocol-correctness/lib/base-types.k"

module LIST-ELEMENTS-ARE-USIZE-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Bool ::= listElementsAreUsize(KItem)  [function, functional]
endmodule

module LIST-ELEMENTS-ARE-USIZE
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX

  rule listElementsAreUsize([.]) => true
  rule listElementsAreUsize([E:Expression, Es:ExpressionCSV])
      => isUsize(E) andBool listElementsAreUsize([Es])
  rule listElementsAreUsize(_:KItem) => false
    [owise]
endmodule