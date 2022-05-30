require "protocol-correctness/lib/functions/forall-v-greater-or-equal-than-u-v-not-in-m.k"
require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/expression.k"

module CAN-ADD-LIST-ELEMENTS-AT-INDEX-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  // Checks that the list elements can be added to the map at consecutive
  // indexes starting with 'index', and ending with 'index + len(list)'.
  // I.e., it checks that none of those indexes is a key in the map.
  //
  // TODO(review): This is a weird function because, among other things, it
  // requires a one element gap after the elements of the list (see below).
  // We should find a better side condition for the init loop.
  // canAddListElementsAtIndex(0, 2 |-> X, [5]) == true
  // canAddListElementsAtIndex(0, 1 |-> X, [5]) == false
  syntax Bool ::= canAddListElementsAtIndex(index:Usize, Map, list:ExpressionList)  [function, functional]
endmodule

module CAN-ADD-LIST-ELEMENTS-AT-INDEX
  imports CAN-ADD-LIST-ELEMENTS-AT-INDEX-SYNTAX

  imports EXPRESSION-SYNTAX
  imports FORALL-V-GREATER-OR-EQUAL-THAN-U-V-NOT-IN-M-SYNTAX

  rule canAddListElementsAtIndex(U:Usize, M:Map, [.]) => forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
  rule canAddListElementsAtIndex(U:Usize, M:Map, [E:Expression , Es:ExpressionCSV] #as L)
      =>  forall-v-greater-or-equal-than-u-v-not-in-m(U, M, L)
          // TODO(review): this is redundant, find a way to remove it.
          andBool canAddListElementsAtIndex(add(U, u(1)), M[U <- E], [Es])
endmodule

