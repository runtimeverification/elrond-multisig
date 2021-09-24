require "protocol-correctness/lib/language/cast.k"
require "protocol-correctness/lib/proof/unsorted/formula-expansion.k"

module MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX
  imports BOOL
  imports FORMULA-EXPANSION-SYNTAX
  imports INT
  imports MAP

  syntax Bool ::= mapKeysAreBelowLimit(lastIndex:Int, Map, expand:PropertyHandling)  [function, functional]
endmodule

module MAP-KEYS-ARE-BELOW-LIMIT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX

  imports CAST-SYNTAX

  // TODO: As defined, this is not functional.
  rule mapKeysAreBelowLimit(_:Int, .Map, _:PropertyHandling) => true
  rule mapKeysAreBelowLimit(LastIndex:Int, (U:Usize |-> _:KItem M:Map) #as _:Map, Handling:PropertyHandling)
    => mapKeysAreBelowLimit(LastIndex, M, Handling)
      andBool LastIndex >Int usizeToInt(U)
    [simplification(30)]
endmodule
