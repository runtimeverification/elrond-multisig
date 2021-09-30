require "protocol-correctness/lib/language/type-reflection.k"

module MAP-KEYS-ARE-OF-TYPE-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP
  imports TYPE-REFLECTION-SYNTAX

  syntax Bool ::= mapKeysAreOfType(Map, ReflectionType)  [function, functional]
endmodule

module MAP-KEYS-ARE-OF-TYPE
  imports MAP-KEYS-ARE-OF-TYPE-SYNTAX

  rule mapKeysAreOfType(.Map, _:ReflectionType) => true
  rule mapKeysAreOfType((K:KItem |-> _:KItem M:Map) #as _:Map, T:ReflectionType)
      => valueOfType(K, T) andBool mapKeysAreOfType(M, T)
    [simplification]
endmodule

