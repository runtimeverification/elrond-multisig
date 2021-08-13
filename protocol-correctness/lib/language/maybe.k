module MAYBE-SYNTAX
  syntax Maybe ::= just(KItem) | "nothing"
  syntax KItem ::= Maybe
  syntax KResult ::= Maybe

  syntax KItem ::= value(KItem)

  syntax KItem ::= orElse(KItem, KItem)  [strict(1)]
endmodule

module MAYBE
  imports MAYBE-SYNTAX

  rule isKResult(value(K:KItem) => K)

  rule orElse(nothing, K:KItem) => value(K)
  rule orElse(just(K:KItem), _:KItem) => value(K)
endmodule
