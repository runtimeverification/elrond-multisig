// breadth = 1
// timeout = moderate
//@ proof

require "../../../0/map/square-bracket/trusted-in-keys-square-bracket-square-bracket.k"  //@ Bazel remove
require "../../../0/map/in-keys/trusted-in-keys-substitution.k"  //@ Bazel remove

module PROOF-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-3

  imports TRUSTED-IN-KEYS-SQUARE-BRACKET-SQUARE-BRACKET
  imports TRUSTED-IN-KEYS-SUBSTITUTION
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// require "protocol-correctness/lib/language/base-types.k"
// require "protocol-correctness/proof/named-lemmas/list-contains-unsafe-list-to-map-set-square-bracket.k"
// module TRUSTED-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-3
//@ end

  imports BASE-TYPES-SYNTAX
  imports K-EQUAL-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-SYNTAX

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
      andBool E =/=K EDelete
      andBool E =/=K E1
    ensures
      #listContainsUnsafe(L, E)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
/*
#listContainsUnsafe(L, E) => true
  requires
    listToMapSet(L)[E1 <- 0][EDelete <- undef]
        ==K listToMapSet(L2)[E <- 0][E1 <- 0][EDelete <- undef]
    andBool E =/=K EDelete
    andBool E =/=K E1

*** call lemmaInKeysSquareBracketSquareBracket(L2, E, E1)
    TRUSTED-IN-KEYS-SQUARE-BRACKET-SQUARE-BRACKET

#listContainsUnsafe(L, E) => true
  requires
    listToMapSet(L)[E1 <- 0][EDelete <- undef]
        ==K listToMapSet(L2)[E <- 0][E1 <- 0][EDelete <- undef]
    andBool E in listToMapSet(L2)[E <- 0][E1 <- 0]
    andBool E =/=K EDelete
    andBool E =/=K E1


*** call lemmaInKeysSubstitution(E, listToMapSet(L)[E1 <- 0], E, listToMapSet(L2)[E <- 0][E1 <- 0])

#listContainsUnsafe(L, E) => true
  requires
    listToMapSet(L)[E1 <- 0][EDelete <- undef]
        ==K listToMapSet(L2)[E <- 0][E1 <- 0][EDelete <- undef]
    andBool E in listToMapSet(L2)[E <- 0][E1 <- 0]
    andBool E in listToMapSet(L)[E1 <- 0]
    andBool E =/=K EDelete
    andBool E =/=K E1

TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET

ok.

*/
