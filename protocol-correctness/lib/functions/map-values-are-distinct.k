require "protocol-correctness/lib/functions/value-not-in-map-values.k"

module MAP-VALUES-ARE-DISTINCT-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapValuesAreDistinct(Map)  [function, functional]
endmodule

module MAP-VALUES-ARE-DISTINCT
  imports MAP-VALUES-ARE-DISTINCT-SYNTAX

  imports VALUE-NOT-IN-MAP-VALUES-SYNTAX

  rule mapValuesAreDistinct(.Map) => true
  rule mapValuesAreDistinct((_:KItem |-> V:KItem M:Map) #as _:Map)
      => mapValuesAreDistinct(M) andBool valueNotInMapValues(V, M)
    [simplification]
endmodule
