// breadth = 2
//@ proof
module PROOF-IN-KEYS-SUBSTITUTION
//@ trusted
// module TRUSTED-IN-KEYS-SUBSTITUTION
//@ end

  imports BOOL
  imports EQUALITY-WITHOUT-SUBSTITUTION-SYNTAX
  imports K-EQUAL-SYNTAX
  imports MAP
  imports NAMED-LEMMA-IN-KEYS-SUBSTITUTION-SYNTAX

  claim lemmaInKeysSubstitution(K1:KItem, M:Map, K2:KItem, N:Map, B:Bool) => .K
    requires true
        andBool equalityWithoutSubstitution(M, N, B)
        andBool equalityWithoutSubstitution(K1, K2, B)
    ensures (K1 in_keys(M)) ==K (K2 in_keys(N))
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
