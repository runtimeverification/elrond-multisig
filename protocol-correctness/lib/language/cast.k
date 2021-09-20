require "protocol-correctness/lib/language/base-types.k"

module CAST-SYNTAX
  imports BASE-TYPES-SYNTAX
  syntax ExpressionList ::= toExpressionListOrDefault(KItem, ExpressionList)  [function, functional]
  syntax Usize ::= toUsizeOrDefault(KItem, Usize)  [function, functional]
  syntax Int ::= usizeToInt(Usize)  [function, functional]
endmodule

module CAST
  imports CAST-SYNTAX

  rule toExpressionListOrDefault(L:ExpressionList, _:ExpressionList) => L
  rule toExpressionListOrDefault(_:KItem, L:ExpressionList) => L  [owise]

  rule toUsizeOrDefault(V:Usize, _:Usize) => V
  rule toUsizeOrDefault(_:KItem, Default:Usize) => Default  [owise]

  rule usizeToInt(u(V:Int)) => V
endmodule
