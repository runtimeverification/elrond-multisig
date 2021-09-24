require "protocol-correctness/lib/language/base-types.k"

module NO-MAP-KEY-IN-LIST-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports MAP

  syntax Bool ::= noMapKeyInList(Map, ExpressionList)  [function, functional]
endmodule

module NO-MAP-KEY-IN-LIST
  imports NO-MAP-KEY-IN-LIST-SYNTAX

  rule noMapKeyInList(.Map, _:ExpressionList) => true
  rule noMapKeyInList(M:Map, [E:Expression, .]) => true
    requires notBool E in_keys(M)
    [simplification]
endmodule
