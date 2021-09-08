// breadth = 1
//@ proof
module PROOF-SQUARE-BRACKET-SUBSTITUTION
//@ trusted
// module TRUSTED-SQUARE-BRACKET-SUBSTITUTION
//@ end

  imports BOOL
  imports EQUALITY-WITHOUT-SUBSTITUTION-SYNTAX
  imports K-EQUAL
  imports MAP
  imports NAMED-LEMMAS-SYNTAX

  claim lemmaSquareBracketSubstitution(
            M:Map, K1:KItem, V1:KItem, N:Map, K2:KItem, V2:KItem, B:Bool)
        => .K
    requires true
        andBool equalityWithoutSubstitution(M, N, B)
        andBool equalityWithoutSubstitution(K1, K2, B)
        andBool equalityWithoutSubstitution(V1, V2, B)
    ensures M[K1 <- V1] ==K N[K2 <- V2]
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
