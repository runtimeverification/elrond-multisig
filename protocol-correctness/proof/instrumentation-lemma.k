require "protocol-correctness/lib/base-types.k"

module INSTRUMENTATION-LEMMA-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax KItem ::= lemmaSplitList(ExpressionList)
  syntax KItem ::= lemmaSplitList2(ExpressionList)

  syntax KItem ::= lemmaSplitListExpression(Expression, ExpressionList)
  syntax KItem ::= lemmaSplitListExpression2(Expression, ExpressionList)
endmodule

module INSTRUMENTATION-LEMMA
  imports INSTRUMENTATION-LEMMA-SYNTAX

  rule  lemmaSplitList([.:ExpressionCSV]) => .K
  rule  lemmaSplitList([_, L:ExpressionCSV])
        => lemmaSplitList([L])

  rule  lemmaSplitList2([.:ExpressionCSV]) => .K
  rule  lemmaSplitList2([_, .:ExpressionCSV]) => .K
  rule  lemmaSplitList2([_, ((_, _:ExpressionCSV) #as L:ExpressionCSV)])
        => lemmaSplitList2([L])

  rule  lemmaSplitListExpression(_:Expression, [.:ExpressionCSV]) => .K
  rule  lemmaSplitListExpression(_:Expression, [E:Expression, L:ExpressionCSV])
        => lemmaSplitListExpression(E, [L])

  rule  lemmaSplitListExpression2(_:Expression, [.:ExpressionCSV]) => .K
  rule  lemmaSplitListExpression2(_:Expression, [_:Expression, .:ExpressionCSV]) => .K
  rule  lemmaSplitListExpression2(_:Expression, [E:Expression, ((_, _:ExpressionCSV) #as L:ExpressionCSV)])
        => lemmaSplitListExpression2(E, [L])
endmodule
