require "protocol-correctness/lib/base-types.k"

module INSTRUMENTATION-LEMMA-SYNTAX
  imports BASE-TYPES-SYNTAX

  syntax KItem ::= lemmaSplitList(ExpressionList)
  syntax KItem ::= lemmaSplitList2(ExpressionList)
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
endmodule
