require "protocol-correctness/lib/language/type-reflection.k"

module VALUE-IS-NOT-EMPTY-SYNTAX
  imports BOOL
  imports TYPE-REFLECTION-SYNTAX

  syntax Bool ::= valueIsNotEmpty(KItem, ReflectionType)  [function, functional]
endmodule

module VALUE-IS-NOT-EMPTY
  imports VALUE-IS-NOT-EMPTY-SYNTAX

  imports K-EQUAL-SYNTAX

  rule valueIsNotEmpty(V:KItem, T:ReflectionType)
      => notBool (V ==K defaultValue(T))
endmodule
