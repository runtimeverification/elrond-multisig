require "protocol-correctness/lib/language/base-types.k"

module PLISTLEN-FUNCTIONS-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax Int ::= pListLen(ExpressionList)  [function, functional, smtlib(pListLen)]
endmodule

module PLISTLEN-FUNCTIONS
  imports PLISTLEN-FUNCTIONS-SYNTAX

  rule pListLen([.]) => 0
  rule pListLen([_:Expression, Es:ExpressionCSV]) => 1 +Int pListLen([Es])

endmodule
