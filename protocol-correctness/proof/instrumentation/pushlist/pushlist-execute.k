require "protocol-correctness/pseudocode.k"

module PUSHLIST-EXECUTE-SYNTAX
  imports PSEUDOCODE-SYNTAX
  imports PSEUDOCODE-FUNCTIONS-SYNTAX

  syntax KItem ::= lemmaPushListNotEmpty(ExpressionCSV, Expression)
endmodule

module PUSHLIST-EXECUTE
  imports PUSHLIST-EXECUTE-SYNTAX
  imports PSEUDOCODE-FUNCTIONS

  rule lemmaPushListNotEmpty(.:ExpressionCSV, _:Expression) => .K
  rule lemmaPushListNotEmpty((_:Expression , _:ExpressionCSV), _:Expression) => .K
endmodule