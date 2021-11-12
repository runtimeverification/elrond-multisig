// breadth = 1
//@ proof
module LEMMA-LIST-CONTAINS-UNSAFE-ELEMENT-LAST-TO-START
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/last-to-start.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// //
// module TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-ELEMENT-LAST-TO-START
//@ end

  imports LAST-TO-START-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX

  lemma
      induction(
        .Induction,
        ("e", E:Expression) <> ("e1", E1:Expression) <> ("e2", E2:Expression) <> ("es", Es:ExpressionCSV)
      ) => .K
    proves
      #listContainsUnsafe
        ( [ E1:Expression, lastToStart(Es:ExpressionCSV) ]
        , E:Expression 
        )
      => #listContainsUnsafe([E1, Es], E)
    requires
      true
    [simplification]
    endlemma

endmodule