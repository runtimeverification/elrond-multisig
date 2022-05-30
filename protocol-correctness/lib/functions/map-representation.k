module MAP-REPRESENTATION-SYNTAX
  imports MAP

  syntax ConcatMap ::= mapConcat(key:KItem, value:KItem, ConcatMap)
      [function, functional, no-evaluators]
  syntax ConcatMap ::= mapOpaque(Map)  [function, functional]

  syntax Map ::= concatToMap(ConcatMap)  [function, functional]
endmodule

module MAP-REPRESENTATION-INTERNAL-SYNTAX
  imports MAP

  syntax Map ::= concatToMapHelper(key:KItem, value:KItem, Map)
    [function, functional]
endmodule

module MAP-REPRESENTATION
  imports MAP-REPRESENTATION-SYNTAX
  imports MAP-REPRESENTATION-INTERNAL-SYNTAX

  imports BOOL

  rule mapOpaque(K:KItem |-> V:KItem M:Map) => mapConcat(K, V, mapOpaque(M))
    ensures notBool K in_keys(M)
    [simplification]

  rule concatToMap(mapOpaque(M:Map)) => M
    [simplification]
  rule concatToMap(mapConcat(K:KItem, V:KItem, M:ConcatMap))
      => concatToMapHelper(K, V, concatToMap(M))
    [simplification]
  
  rule concatToMapHelper(K:KItem, V:KItem, M:Map) => K |-> V M
    requires notBool K in_keys(M)
  rule concatToMapHelper(K:KItem, _V:KItem, M:Map) => M
    requires K in_keys(M)
endmodule
