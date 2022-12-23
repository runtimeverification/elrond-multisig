require "protocol-correctness/lib/functions/keys-map.k"

module MAP-VALUES-BECOME-KEYS-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapValuesBecomeKeys(Map, Map)  [function, functional]
endmodule

module MAP-VALUES-BECOME-KEYS-ADDITIONAL-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= #mapValuesBecomeKeys(Map, Map)  [function, functional]
endmodule

module MAP-VALUES-BECOME-KEYS
  imports MAP-VALUES-BECOME-KEYS-ADDITIONAL-SYNTAX
  imports MAP-VALUES-BECOME-KEYS-SYNTAX

  imports KEYS-MAP-SYNTAX

  rule mapValuesBecomeKeys(M:Map, N:Map) => #mapValuesBecomeKeys(M, keysMap(N))

  rule #mapValuesBecomeKeys(.Map, _:Map) => true
  rule #mapValuesBecomeKeys(K |-> V M:Map, N:Map)
      => V in_keys(N) andBool #mapValuesBecomeKeys(M, N)
    ensures notBool K in_keys(M)
    [simplification]
endmodule
