// breadth = 10
//@ proof

module PROOF-LAST-DISTINCT
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// module TRUSTED-LAST-DISTINCT
//@ end
  imports K-EQUAL
  imports LAST-FUNCTIONS
  imports LIST-ELEMENTS-ARE-DISTINCT-SYNTAX

  claim lemmaLastDistinct(E1, E2, Es) => .K
      requires listElementsAreDistinct([E1, E2, Es])
      ensures E1 =/=K #last(E2, Es)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
