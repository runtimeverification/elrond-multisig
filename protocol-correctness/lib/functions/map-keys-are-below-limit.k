require "protocol-correctness/lib/functions/map-keys-are-of-type.k"
require "protocol-correctness/lib/language/cast.k"
require "protocol-correctness/lib/proof/unsorted/formula-expansion.k"

module MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports BOOL
  imports FORMULA-EXPANSION-SYNTAX
  imports INT
  imports MAP

  syntax Bool ::= mapKeysAreBelowLimitSafe(lastIndex:Int, Map, expand:PropertyHandling)  [function]
endmodule

module MAP-KEYS-ARE-BELOW-LIMIT-ADDITIONAL-SYNTAX
  imports BOOL
  imports FORMULA-EXPANSION-SYNTAX
  imports INT
  imports MAP

  syntax Bool ::= mapKeysAreBelowLimitUnsafe(lastIndex:Int, Map, expand:PropertyHandling)  [function, functional]
endmodule

module MAP-KEYS-ARE-BELOW-LIMIT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-KEYS-ARE-BELOW-LIMIT-ADDITIONAL-SYNTAX

  imports CAST-SYNTAX
  imports MAP-KEYS-ARE-OF-TYPE-SYNTAX

  rule mapKeysAreBelowLimitSafe(LastIndex:Int, M:Map, Handling:PropertyHandling)
    => mapKeysAreBelowLimitUnsafe(LastIndex, M, Handling)
    requires mapKeysAreOfType(M, rUsize)

  rule mapKeysAreBelowLimitUnsafe(_:Int, .Map, _:PropertyHandling) => true
  rule mapKeysAreBelowLimitUnsafe(LastIndex:Int, (K:KItem |-> _:KItem M:Map) #as _:Map, Handling:PropertyHandling)
    => mapKeysAreBelowLimitUnsafe(LastIndex, M, Handling)
      andBool LastIndex >Int usizeToInt(toUsizeOrDefault(K, u(0)))
    [simplification(30)]
endmodule
