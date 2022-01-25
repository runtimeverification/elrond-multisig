// breadth = 1
// UNFINISHED
//@ proof
module PROOF-LIST-TO-MAP-SET-CONCRETIZE
//@ trusted
// module TRUSTED-LIST-TO-MAP-SET-CONCRETIZE
//@ end

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-ADDITIONAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports NAMED-LEMMA-LIST-TO-MAP-SET-CONCRETIZE-SYNTAX
  imports NO-MAP-KEY-IN-LIST-SYNTAX

  claim lemmaListToMapSetConcretize(L:ExpressionCSV, E1:Expression, E2:Expression) => .K
    requires true
        andBool listToMapSet([L])[E1 <- 0][E2 <- undef]
            ==K E1 |-> 0
        andBool notBool #listContainsUnsafe([L], E1)
        andBool listElementsAreDistinctUnsafe([L])
        andBool notBool E1 ==K E2
    ensures [E1, L] ==K [E1, .] orBool [E1, L] ==K [E1, E2, .]
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
