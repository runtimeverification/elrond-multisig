require "protocol-correctness/lib/language/base-types.k"

module PREPEND-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= prepend(ExpressionCSV, Expression) [function, functional]

endmodule

module PREPEND
  imports PREPEND-SYNTAX

  rule prepend(Es:ExpressionCSV, E:Expression) => E , Es

endmodule

