require "protocol-correctness/lib/functions/concretize-value.k"
require "protocol-correctness/lib/language/base-types.k"

module CONCRETIZE-EXPRESSION-LIST-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports INT
  
  syntax KItem ::= concretizeExpressionList(ExpressionList, Int)
endmodule

module CONCRETIZE-EXPRESSION-LIST
  imports CONCRETIZE-EXPRESSION-LIST-SYNTAX
  imports CONCRETIZE-VALUE-SYNTAX

  rule concretizeExpressionList([.:ExpressionCSV], X:Int) => .K
    requires X >Int 0
  rule concretizeExpressionList([_:Expression , L:ExpressionCSV], X:Int)
      => concretizeExpressionList([L], X -Int 1)
    requires X >Int 0
    [label(concretizeListElement)]
  rule concretizeExpressionList([_:ExpressionCSV], X:Int)
      => .K
    requires X <=Int 0
    [label(concretizeListEnd)]
endmodule
