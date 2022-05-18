require "protocol-correctness/lib/language/reflection.k"

module NAMED-LEMMA-IN-KEYS-SUBSTITUTION-SYNTAX
  imports BOOL
  imports MAP

  syntax KItem ::= lemmaInKeysSubstitution(k1:KItem, m1:Map, k2:KItem, m2:Map, Bool)
endmodule

module NAMED-LEMMA-IN-KEYS-SUBSTITUTION
  imports NAMED-LEMMA-IN-KEYS-SUBSTITUTION-SYNTAX
  imports REFLECTION-SYNTAX

  rule lemmaInKeysSubstitution(_:KItem, _:Map, _:KItem, _:Map, true) => .K
  rule lemmaInKeysSubstitution(_:KItem, _:Map, _:KItem, _:Map, false) => .K

  // You must not forget the last bool arg (true).
  rule reflectionApply($lemmaInKeysSubstitution,
          ( reflectionArgument(K1:KItem)
          , reflectionArgument(M:Map)
          , reflectionArgument(K2:KItem)
          , reflectionArgument(N:Map)
          , reflectionArgument(B:Bool)))
    => lemmaInKeysSubstitution(K1, M, K2, N, B)

endmodule