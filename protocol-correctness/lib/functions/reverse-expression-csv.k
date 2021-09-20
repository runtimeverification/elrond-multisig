require "protocol-correctness/lib/language/base-types.k"

module REVERSE-EXPRESSION-CSV-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= reverseExpressionCsv(ExpressionCSV, ExpressionCSV)  [function, functional]
endmodule

module REVERSE-EXPRESSION-CSV
  imports REVERSE-EXPRESSION-CSV-SYNTAX

  rule reverseExpressionCsv(., L2:ExpressionCSV) => L2
  rule reverseExpressionCsv((E:Expression , Es:ExpressionCSV), L2:ExpressionCSV) => reverseExpressionCsv(Es, (E , L2))
endmodule

