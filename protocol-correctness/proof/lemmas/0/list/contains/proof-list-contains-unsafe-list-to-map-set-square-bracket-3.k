// breadth = 2
//@ proof
module PROOF-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-3
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// require "protocol-correctness/proof/named-lemmas/list-contains-unsafe-list-to-map-set-square-bracket.k"
// module TRUSTED-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-3
//@ end

  imports BOOL
  imports K-EQUAL-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports NAMED-LEMMAS-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-SYNTAX

  claim
      lemmaListContainsUnsafeListToMapSetSquareBracket3(
          E:Expression,
          L:ExpressionList,
          E1:Expression,
          EDelete:Expression,
          L2:ExpressionList)
      => .K
    requires
      listToMapSet(L)[E1 <- 0][EDelete <- undef]
      ==K listToMapSet(L2)[E <- 0][E1 <- 0][EDelete <- undef]
    ensures
      #listContainsUnsafe(L, E)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
