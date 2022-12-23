require "protocol-correctness/lib/functions/forall-v-greater-or-equal-than-u-v-not-in-m.k"
require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/expression.k"

module CAN-ADD-LIST-ELEMENTS-AT-INDEX-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  // Checks that the list elements can be added to the map at consecutive
  // indexes starting with 'index', and that 'index + len(list)' is not in the
  // map
  syntax Bool ::= canAddListElementsAtIndex(index:Usize, Map, list:ExpressionList)  [function, functional]
endmodule

module CAN-ADD-LIST-ELEMENTS-AT-INDEX
  imports CAN-ADD-LIST-ELEMENTS-AT-INDEX-SYNTAX

  imports EXPRESSION-SYNTAX
  imports FORALL-V-GREATER-OR-EQUAL-THAN-U-V-NOT-IN-M-SYNTAX

  rule canAddListElementsAtIndex(U:Usize, M:Map, [.]) => forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
  rule canAddListElementsAtIndex(U:Usize, M:Map, [E:Expression , Es:ExpressionCSV] #as L)
      =>  forall-v-greater-or-equal-than-u-v-not-in-m(U, M, L)
          andBool canAddListElementsAtIndex(add(U, u(1)), M[U <- E], [Es])
endmodule

