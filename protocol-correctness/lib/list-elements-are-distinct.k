require "protocol-correctness/lib/base-types.k"
require "protocol-correctness/lib/list-contains.k"

module LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  syntax KItem
  
  syntax Bool ::= listElementsAreDistinct(KItem)  [function, functional]
endmodule

module LIST-ELEMENTS-ARE-DISTINCT
  imports BASE-TYPES-SYNTAX
  imports LIST-CONTAINS-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX
  
  rule listElementsAreDistinct([.]) => true
  rule listElementsAreDistinct([E:Expression, Es:ExpressionCSV])
      => true
          andBool notBool #listContains([Es], E)
          andBool listElementsAreDistinct([Es])
  rule listElementsAreDistinct(_:KItem) => false
    [owise]
endmodule
