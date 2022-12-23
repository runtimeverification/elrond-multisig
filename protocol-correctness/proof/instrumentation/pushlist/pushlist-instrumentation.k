require "protocol-correctness/pseudocode.k"

module PUSHLIST-INSTRUMENTATION-SYNTAX
  imports PSEUDOCODE-SYNTAX
  imports PSEUDOCODE-FUNCTIONS-SYNTAX

  syntax KItem ::= lemmaPushListNotEmpty(ExpressionCSV, Expression)
endmodule

module PUSHLIST-INSTRUMENTATION
  imports PUSHLIST-INSTRUMENTATION-SYNTAX
  imports PSEUDOCODE-FUNCTIONS

  rule lemmaPushListNotEmpty(.:ExpressionCSV, _:Expression) => .K
  rule lemmaPushListNotEmpty((_:Expression , _:ExpressionCSV), _:Expression) => .K
endmodule