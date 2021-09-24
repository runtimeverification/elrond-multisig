module MAP-INCLUDED-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapIncluded(Map, Map) [function, functional]
endmodule

module MAP-INCLUDED
  imports MAP-INCLUDED-SYNTAX

  imports K-EQUAL-SYNTAX

  rule mapIncluded(.Map, _:Map) => true
  rule mapIncluded((K:KItem |-> V:KItem M:Map) #as _:Map, N:Map)
      => K in_keys(N) andBool N[K] ==K V andBool mapIncluded(M, N)
    [simplification]
endmodule

