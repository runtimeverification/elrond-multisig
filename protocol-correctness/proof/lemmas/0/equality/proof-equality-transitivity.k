// breadth = 1
//@ proof
module PROOF-EQUALITY-TRANSITIVITY
//@ trusted
// module TRUSTED-EQUALITY-TRANSITIVITY
//@ end

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports MAP
  imports NAMED-LEMMAS-SYNTAX

  claim lemmaEqualityTransitivity(A:KItem, B:KItem, C:KItem) => .K
    requires true
        andBool A ==K B
        andBool B ==K C
    ensures A ==K C
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
