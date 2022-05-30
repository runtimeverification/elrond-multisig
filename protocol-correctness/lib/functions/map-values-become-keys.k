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

  // This function was widely used as part of the contract invariant,
  // but right now it's used only in a single proof.

  // This transforms the second map into one in which all values are 0
  // in order to make it easy to predict the next invariant condition,
  // e.g. when calling an endpoint that adds a user - without this,
  // one would need to know the value that is being added to the N map.
  // It is not clear if this is still relevant in the remaining proof that
  // uses it.
  rule mapValuesBecomeKeys(M:Map, N:Map) => #mapValuesBecomeKeys(M, keysMap(N))

  rule #mapValuesBecomeKeys(.Map, _:Map) => true
  rule #mapValuesBecomeKeys(K |-> V M:Map, N:Map)
      => V in_keys(N) andBool #mapValuesBecomeKeys(M, N)
    ensures notBool K in_keys(M)
    [simplification]
endmodule
