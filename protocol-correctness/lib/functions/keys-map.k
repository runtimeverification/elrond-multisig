module KEYS-MAP-SYNTAX
  imports MAP

  syntax Map ::= keysMap(Map)  [function, functional]
endmodule

module KEYS-MAP
  imports KEYS-MAP-SYNTAX

  imports INT
  imports MAP

  rule keysMap(.Map) => .Map
  rule keysMap(K:KItem |-> _:KItem M:Map) => K |-> 0 keysMap(M)
    [simplification]
endmodule
