require "protocol-correctness/lib/language/cast.k"
require "protocol-correctness/lib/proof/unsorted/formula-expansion.k"

module MAP-VALUES-ARE-BELOW-LIMIT-SYNTAX
  imports BOOL
  imports FORMULA-EXPANSION-SYNTAX
  imports INT
  imports MAP

  syntax Bool ::= mapValuesAreBelowLimit(Int, Map, PropertyHandling)  [function, functional]
endmodule

module MAP-VALUES-ARE-BELOW-LIMIT-ADDITIONAL-SYNTAX
  imports BOOL
  imports FORMULA-EXPANSION-SYNTAX
  imports INT
  imports MAP

  syntax Bool ::= #mapValuesAreBelowLimit(Int, Map, PropertyHandling)  [function, functional]
endmodule

module MAP-VALUES-ARE-BELOW-LIMIT
  imports MAP-VALUES-ARE-BELOW-LIMIT-SYNTAX
  imports MAP-VALUES-ARE-BELOW-LIMIT-ADDITIONAL-SYNTAX

  imports CAST-SYNTAX

  // TODO: As defined, this is not functional.
  rule mapValuesAreBelowLimit(_Index:Int, .Map, _:PropertyHandling) => true
  rule mapValuesAreBelowLimit(Index:Int, (_:KItem |-> V:Usize M:Map) #as _:Map, Expand:PropertyHandling)
      => Index >Int usizeToInt(V) andBool mapValuesAreBelowLimit(Index, M, Expand)
    [simplification(20)]

  // TODO: Why is this not defined for anything besides `expanded`?
  // TODO: Why is this needed at all, why not just use `mapValuesAreBelowLimit`?
  // TODO: As defined, this is not functional (expanded and Usize).
  rule #mapValuesAreBelowLimit(_Index:Int, .Map, expanded) => true
  rule #mapValuesAreBelowLimit(Index:Int, (_:KItem |-> V:Usize M:Map) #as _:Map, Expand:PropertyHandling)
      => Index >Int usizeToInt(V) andBool #mapValuesAreBelowLimit(Index, M, Expand)
    [simplification(20)]

endmodule
