require "protocol-correctness/lib/language/base-types.k"

module REVERSE-EXPRESSION-CSV-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= reverseExpressionCSV(ExpressionCSV, ExpressionCSV)  [function, functional]
endmodule

module REVERSE-EXPRESSION-CSV
  imports REVERSE-EXPRESSION-CSV-SYNTAX

  rule reverseExpressionCSV(., L2:ExpressionCSV) => L2
  rule reverseExpressionCSV((E:Expression , Es:ExpressionCSV), L2:ExpressionCSV) => reverseExpressionCSV(Es, (E , L2))
endmodule

