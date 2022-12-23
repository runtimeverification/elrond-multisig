// breadth = 1
//@ proof
module LEMMA-LIST-CONTAINS-UNSAFE-SECOND-ELEMENT
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// //
// module TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-SECOND-ELEMENT
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports K-EQUAL-SYNTAX

  lemma
      induction(
        .Induction,
        ("e", E:Expression) <> ("e1", E1:Expression) <> ("es", Es:ExpressionCSV)
      ) => .K
    proves
      #listContainsUnsafe
        ( [ E1:Expression, E2:Expression, Es:ExpressionCSV ]
        , E:Expression 
        )
      => #listContainsUnsafe([E1, Es], E)
    requires
      E =/=K E2
    [simplification]
    endlemma

endmodule