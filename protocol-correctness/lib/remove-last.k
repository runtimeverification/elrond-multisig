require "protocol-correctness/lib/base-types.k"
require "protocol-correctness/lib/plistlen-functions.k"

module REMOVE-LAST-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= removeLast(ExpressionCSV)  [function]
endmodule

module REMOVE-LAST
  imports REMOVE-LAST-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX

  rule removeLast(_:Expression, .) => .:ExpressionCSV
  rule removeLast(E:Expression, Es:ExpressionCSV) => E, removeLast(Es)
    requires pListLen([Es]) >Int 0
endmodule