require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/language/expression.k"

module FORALL-V-GREATER-OR-EQUAL-THAN-U-V-NOT-IN-M-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= "forall-v-greater-or-equal-than-u-v-not-in-m" "(" Usize "," Map "," ExpressionList ")"   [function, functional]
endmodule

module FORALL-V-GREATER-OR-EQUAL-THAN-U-V-NOT-IN-M
  imports FORALL-V-GREATER-OR-EQUAL-THAN-U-V-NOT-IN-M-SYNTAX

  imports EXPRESSION-SYNTAX

  rule forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [.])
      =>  notBool U in_keys(M)
  rule forall-v-greater-or-equal-than-u-v-not-in-m(U, M, [_:Expression , Es:ExpressionCSV])
      =>  notBool U in_keys(M)
          andBool forall-v-greater-or-equal-than-u-v-not-in-m(add(U, u(1)), M, [Es])
endmodule

