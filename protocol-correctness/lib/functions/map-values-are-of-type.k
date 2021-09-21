require "protocol-correctness/lib/language/type-reflection.k"

module MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports BOOL
  imports MAP
  imports TYPE-REFLECTION-SYNTAX

  syntax Bool ::= mapValuesAreOfType(Map, ReflectionType)  [function, functional]

endmodule

module MAP-VALUES-ARE-OF-TYPE
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  
  rule mapValuesAreOfType(.Map, _:ReflectionType) => true
  rule mapValuesAreOfType((_ |-> V M:Map) #as _:Map, T:ReflectionType)
      => valueOfType(V, T) andBool mapValuesAreOfType(M, T)
    [simplification]

endmodule

