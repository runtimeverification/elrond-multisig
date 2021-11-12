// breadth = 1
//@ proof
module LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-EQ
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-elements-are-distinct.k"
// require "protocol-correctness/lib/functions/list-find.k"
// require "protocol-correctness/lib/functions/list-swap-remove.k"
// //
// module TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-EQ
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-ADDITIONAL-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX

  lemma
      induction(
        .Induction,
        ("e", E:Expression)
          <> ("es", Es:ExpressionCSV)
      ) => .K
    proves
      #listContainsUnsafe
        ( [ #listSwapRemove(Es:ExpressionCSV, #listFindUnsafe([Es], E)) ]
        , E:Expression 
        )
      => false
    requires
      true
      andBool listElementsAreDistinctUnsafe([Es])
    [simplification]
    endlemma

endmodule