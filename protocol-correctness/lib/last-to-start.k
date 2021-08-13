require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/last-functions.k"
require "protocol-correctness/lib/plistlen-functions.k"
require "protocol-correctness/lib/remove-last.k"

module LAST-TO-START-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax ExpressionCSV ::= lastToStart(ExpressionCSV)  [function, functional]
endmodule

module LAST-TO-START
  imports LAST-FUNCTIONS-SYNTAX
  imports LAST-TO-START-SYNTAX
  imports PLISTLEN-FUNCTIONS-SYNTAX
  imports REMOVE-LAST-SYNTAX

  rule lastToStart(.) => .:ExpressionCSV
  rule lastToStart(Es:ExpressionCSV) => last(Es), removeLast(Es)
    requires pListLen([Es]) >Int 0
endmodule