module BOOL-TO-INT-SYNTAX
  imports BOOL
  imports INT

  syntax Int ::= boolToInt(Bool)  [function, functional, smtlib(boolToInt)]
endmodule

module BOOL-TO-INT
  imports BOOL-TO-INT-SYNTAX

  rule boolToInt(true) => 1
  rule boolToInt(false) => 0
endmodule

