module VALUE-NOT-IN-MAP-VALUES-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= valueNotInMapValues(KItem, Map)  [function, functional]
endmodule

module VALUE-NOT-IN-MAP-VALUES
  imports VALUE-NOT-IN-MAP-VALUES-SYNTAX

  imports K-EQUAL-SYNTAX

  rule valueNotInMapValues(_:KItem, .Map) => true
  rule valueNotInMapValues(V1:KItem, (_:KItem |-> V2:KItem M:Map) #as _:Map)
      => (notBool (V1 ==K V2)) andBool valueNotInMapValues(V1, M)
    [simplification]
endmodule

