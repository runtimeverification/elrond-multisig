require "protocol-correctness/lib/language/type-reflection.k"

module LIST-ELEMENTS-ARE-OF-TYPE-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports TYPE-REFLECTION-SYNTAX

  syntax Bool ::= listElementsAreOfType(ExpressionList, ReflectionType)  [function, functional]
endmodule

module LIST-ELEMENTS-ARE-OF-TYPE
  imports LIST-ELEMENTS-ARE-OF-TYPE-SYNTAX

  rule listElementsAreOfType([.], _:ReflectionType) => true
  rule listElementsAreOfType([E:Expression, Es:ExpressionCSV], T:ReflectionType)
      => valueOfType(E, T) andBool listElementsAreOfType([Es], T)
endmodule

