module MAP-VALUES-ARE-0-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapValuesAre0(Map)  [function, functional]
endmodule

module MAP-VALUES-ARE-0
  imports INT
  imports K-EQUAL-SYNTAX
  imports MAP-VALUES-ARE-0-SYNTAX

  rule mapValuesAre0(.Map) => true
  rule mapValuesAre0((_:KItem |-> V:KItem M:Map) #as _:Map)
      => mapValuesAre0(M) andBool (V ==K 0)
    [simplification]
endmodule
