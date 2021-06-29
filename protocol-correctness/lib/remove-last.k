require "protocol-correctness/lib/base-types.k"
require "protocol-correctness/lib/plistlen-functions.k"

module REMOVE-LAST-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= removeLast(ExpressionCSV)  [function]
endmodule

module REMOVE-LAST
  imports REMOVE-LAST-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX

  syntax ExpressionCSV ::= #removeLast(Expression, ExpressionCSV)  [function, functional]
  syntax ExpressionCSV ::= #removeLast0(ExpressionCSV)  [function, functional]

  rule removeLast(E:Expression, Es:ExpressionCSV) => #removeLast(E, Es)

  rule #removeLast(_:Expression, .)
      => .:ExpressionCSV
  rule #removeLast(E:Expression, Es:ExpressionCSV)
      => E, #removeLast0(Es)
      requires pListLen([Es]) >Int 0

  rule #removeLast0(.) => .
  rule #removeLast0(E:Expression, Es:ExpressionCSV) => #removeLast(E, Es)
endmodule