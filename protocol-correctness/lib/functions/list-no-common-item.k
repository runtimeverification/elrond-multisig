require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/expression.k"

module LIST-NO-COMMON-ITEM-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  // Checks that no key in the ExpressionList is part of the map.
  // This function is used in a loop invariant, so, in the recursive call,
  // it tries to produce a map identical to the one produced by the loop.
  // The Usize argument is the next value to use in the map.
  syntax Bool ::= listNoCommonItem(Usize, Map, ExpressionList)  [function, functional]
endmodule

module LIST-NO-COMMON-ITEM
  imports LIST-NO-COMMON-ITEM-SYNTAX

  imports EXPRESSION-SYNTAX

  rule listNoCommonItem(_:Usize, _:Map, [.]) => true
  rule listNoCommonItem(U:Usize, M:Map, [E:Expression , Es:ExpressionCSV])
      =>  notBool (E in_keys(M))
          andBool listNoCommonItem(add(U, u(1)), (E |-> U) M, [Es])
endmodule