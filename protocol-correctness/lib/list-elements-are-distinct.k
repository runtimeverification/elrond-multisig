require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/list-contains.k"

module LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  syntax KItem
  
  syntax Bool ::= listElementsAreDistinctSafe(KItem)  [function]
endmodule

module LIST-ELEMENTS-ARE-DISTINCT-ADDITIONAL-SYNTAX
  syntax KItem
  
  syntax Bool ::= listElementsAreDistinctUnsafe(KItem)  [function, functional]
endmodule

module LIST-ELEMENTS-ARE-DISTINCT
  imports BASE-TYPES-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-ADDITIONAL-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  
  rule listElementsAreDistinctSafe(Es) => listElementsAreDistinctUnsafe(Es)
    requires isKResult(Es)

  rule listElementsAreDistinctUnsafe([.]) => true
  rule listElementsAreDistinctUnsafe([E:Expression, Es:ExpressionCSV])
      => true
          andBool notBool #listContainsUnsafe([Es], E)
          andBool listElementsAreDistinctUnsafe([Es])
  rule listElementsAreDistinctUnsafe(_:KItem) => false
    [owise]
endmodule
