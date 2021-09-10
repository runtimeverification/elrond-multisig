// breadth = 5
//@ proof
module PROOF-COMMUTE-SQUARE-BRACKET
//@ trusted
// module TRUSTED-COMMUTE-SQUARE-BRACKET
//@ end

  imports K-EQUAL
  imports MAP
  imports NAMED-LEMMAS-SYNTAX

  claim lemmaCommuteMapSquareBracketAssignmentSameValue(
            M:Map, K1:KItem, K2:KItem, V:KItem)
        => .K
    ensures M[K1 <- V][K2 <- V] ==K M[K2 <- V][K1 <- V]
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  claim lemmaCommuteMapSquareBracketAssignmentDifferentKeys(
            M:Map, K1:KItem, V1:KItem, K2:KItem, V2:KItem)
        => .K
    requires K1 =/=K K2
    ensures M[K1 <- V1][K2 <- V2] ==K M[K2 <- V2][K1 <- V1]
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  claim lemmaCommuteMapSquareBracketAssignmentDelete(
            M:Map, K1:KItem, V1:KItem, K2:KItem)
        => .K
    requires K1 =/=K K2
    ensures M[K1 <- V1][K2 <- undef] ==K M[K2 <- undef][K1 <- V1]
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

  claim lemmaCommuteMapSquareBracketDelete(
            M:Map, K1:KItem, K2:KItem)
        => .K
    ensures M[K1 <- undef][K2 <- undef] ==K M[K2 <- undef][K1 <- undef]
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
