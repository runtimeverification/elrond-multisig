require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/functions/value-is-not-empty.k"

module MAP-VALUES-ARE-NOT-EMPTY-SYNTAX
  imports BOOL
  imports MAP
  imports TYPE-REFLECTION-SYNTAX

  syntax Bool ::= mapValuesAreNotEmpty(Map, ReflectionType)  [function, functional]
endmodule

module MAP-VALUES-ARE-NOT-EMPTY
  imports MAP-VALUES-ARE-NOT-EMPTY-SYNTAX

  imports VALUE-IS-NOT-EMPTY-SYNTAX

  rule mapValuesAreNotEmpty(.Map, _:ReflectionType) => true
  rule mapValuesAreNotEmpty((_ |-> V M:Map) #as _:Map, T:ReflectionType)
      => mapValuesAreNotEmpty(M, T) andBool valueIsNotEmpty(V, T)
    [simplification]
endmodule
