require "protocol-correctness/lib/language/base-types.k"

module MAP-VALUES-ARE-KRESULT-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= mapValuesAreKResult(Map)  [function, functional]
endmodule

module MAP-VALUES-ARE-KRESULT
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports BASE-TYPES-SYNTAX

  rule mapValuesAreKResult(.Map) => true
  rule mapValuesAreKResult((_ |-> V M:Map) #as _:Map)
      => isKResult(V) andBool mapValuesAreKResult(M)
    [simplification]
endmodule

