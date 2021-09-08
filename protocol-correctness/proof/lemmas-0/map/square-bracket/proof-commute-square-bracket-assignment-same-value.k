// breadth = 5
//@ proof
module PROOF-COMMUTE-SQUARE-BRACKET-ASSIGNMENT-SAME-VALUE
//@ trusted
// module TRUSTED-COMMUTE-SQUARE-BRACKET-ASSIGNMENT-SAME-VALUE
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

endmodule
