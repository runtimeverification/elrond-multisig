require "protocol-correctness/lib/functions/forall-v-greater-or-equal-than-u-v-not-in-m.k"
require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/expression.k"

module CAN-ADD-VALUE-FOR-LIST-ELEMENTS-AT-INDEX-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  // Checks that 'value' can be added to the map for each list element at
  // consecutive indexes starting with 'index', and that 'index + len(list)' is
  // not in the map.
  syntax Bool ::= canAddValueForListElementsAtIndex(
                      index:Usize, Map, list:ExpressionList, value:KItem
                  )  [function, functional]
endmodule

module CAN-ADD-VALUE-FOR-LIST-ELEMENTS-AT-INDEX
  imports CAN-ADD-VALUE-FOR-LIST-ELEMENTS-AT-INDEX-SYNTAX

  imports EXPRESSION-SYNTAX
  imports FORALL-V-GREATER-OR-EQUAL-THAN-U-V-NOT-IN-M-SYNTAX

  rule canAddValueForListElementsAtIndex(U:Usize, M:Map, [.], _:KItem)
      => forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
  rule canAddValueForListElementsAtIndex(
          U:Usize, M:Map, [_E:Expression , Es:ExpressionCSV] #as L, Value:KItem
      )
      =>  forall-v-greater-or-equal-than-u-v-not-in-m(U, M, L)
          andBool canAddValueForListElementsAtIndex(add(U, u(1)), M[U <- Value], [Es], Value)
endmodule

