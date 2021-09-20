require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/functions/prepend.k"

module PUSH-LIST-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= #pushList(ExpressionCSV, Expression) [function, functional]

endmodule

module PUSH-LIST
  imports PUSH-LIST-SYNTAX

  imports PREPEND-SYNTAX

  rule #pushList(., E:Expression)
        => E, .
  rule #pushList(E:Expression , Es:ExpressionCSV, E2:Expression)
        => prepend(#pushList(Es, E2), E)

endmodule

