module EQUALITY-WITHOUT-SUBSTITUTION-SYNTAX
  imports BOOL

  syntax Bool ::= equalityWithoutSubstitution(first:KItem, second:KItem, justReturnFalse:Bool)  [function]
endmodule

module EQUALITY-WITHOUT-SUBSTITUTION
  imports EQUALITY-WITHOUT-SUBSTITUTION-SYNTAX
  imports K-EQUAL

  rule equalityWithoutSubstitution(First:KItem, Second:KItem, true:Bool)
      => First ==K Second
  rule equalityWithoutSubstitution(_First:KItem, _Second:KItem, false:Bool)
      => false
endmodule

