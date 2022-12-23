// breadth = 2
//@ proof
module LEMMA-LIST-FIND-LT-0
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-find.k"
// 
// module TRUSTED-LEMMA-LIST-FIND-LT-0
//@ end

  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports K-EQUAL-SYNTAX

  lemma
      induction(
          .Induction,
          ("e", E:Expression) <> ("e1", E1:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      #listFindUnsafe([E1, Es], E) <Int 0 => #listFindUnsafe([Es], E) <Int 0
    requires
      E1 =/=K E
    [simplification]
    endlemma

endmodule
