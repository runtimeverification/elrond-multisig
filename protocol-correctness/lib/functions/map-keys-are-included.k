// Previously called ALL-KEYS-BECOME-KEYS
module MAP-KEYS-ARE-INCLUDED-SYNTAX
  imports MAP

  // Previously called allKeysBecomeKeys
  syntax Bool ::= mapKeysAreIncluded(Map, Map)  [function, functional]
endmodule

module MAP-KEYS-ARE-INCLUDED
  imports MAP-KEYS-ARE-INCLUDED-SYNTAX

  imports BOOL

  rule mapKeysAreIncluded(.Map, _:Map) => true
  rule mapKeysAreIncluded(K:KItem |-> _:KItem M:Map, N:Map)
      => K in_keys(N) andBool mapKeysAreIncluded(M, N)
    [simplification]
endmodule

