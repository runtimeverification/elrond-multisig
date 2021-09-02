// breadth = 1
//@ proof
module LEMMA-LIST-CONTAINS-POUND-LAST
  imports LEMMAS-EXECUTE-SYNTAX
//@ trusted
// require "protocol-correctness/lib/list-contains.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-POUND-LAST
//@ end

  imports LIST-CONTAINS-SYNTAX

  lemma
      .K => .K
    proves
      #listContains([E, Es], #last(E, Es)) => true
    requires
      true
    [simplification]
    endlemma

endmodule
