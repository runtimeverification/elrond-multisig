module ALL-KEYS-BECOME-KEYS-SYNTAX
  imports MAP

  syntax Bool ::= allKeysBecomeKeys(Map, Map)  [function, functional]
endmodule

module ALL-KEYS-BECOME-KEYS
  imports ALL-KEYS-BECOME-KEYS-SYNTAX

  imports BOOL

  rule allKeysBecomeKeys(.Map, _:Map) => true
  rule allKeysBecomeKeys(K:KItem |-> _:KItem M:Map, N:Map)
      => K in_keys(N) andBool allKeysBecomeKeys(M, N)
    [simplification]
endmodule

