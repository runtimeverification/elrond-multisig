require "protocol-correctness/lib/language/base-types.k"

module MAP-KEYS-ARE-KRESULT-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapKeysAreKResult(Map)  [function, functional]
endmodule

module MAP-KEYS-ARE-KRESULT
  imports MAP-KEYS-ARE-KRESULT-SYNTAX
  imports BASE-TYPES-SYNTAX

  rule mapKeysAreKResult(.Map) => true
  rule mapKeysAreKResult((K:KItem |-> _:KItem M:Map) #as _:Map)
      => isKResult(K) andBool mapKeysAreKResult(M)
    [simplification]
endmodule
