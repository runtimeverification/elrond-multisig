// breadth = 1
//@ proof

require "../../../0/list/contains/trusted-list-contains-unsafe-to-in-keys.k"  //@ Bazel remove
require "../../../0/map/in-keys/trusted-in-keys-substitution.k"  //@ Bazel remove

module PROOF-LIST-CONTAINS-UNSAFE-CHANGE-LIST-3

  imports TRUSTED-LIST-CONTAINS-UNSAFE-TO-IN-KEYS
  imports TRUSTED-IN-KEYS-SUBSTITUTION
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// require "protocol-correctness/proof/named-lemmas/list-contains-unsafe-change-list-3.k"
// module TRUSTED-LIST-CONTAINS-UNSAFE-CHANGE-LIST-3
//@ end

  imports K-EQUAL-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-CHANGE-LIST-3-SYNTAX

  claim
      lemmaListContainsUnsafeChangeList3
          ( E:KItem
          , E1:KItem
          , E2:KItem
          , EDelete:KItem
          , Es1:ExpressionCSV
          , Es2:ExpressionCSV
          )
      => .K
    requires
      listToMapSet([Es1])[E2 <- 0][EDelete <- undef]
          ==K listToMapSet([Es2])[E1 <- 0][E2 <- 0][EDelete <- undef]
      andBool E =/=K EDelete
      andBool E =/=K E1
      andBool E =/=K E2
    ensures
      #listContainsUnsafe([Es1], E) ==K #listContainsUnsafe([Es2], E)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
/*
#listContainsUnsafe(L1, K) ==K #listContainsUnsafe(L2, K))
  requires true
      andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
              ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
      andBool E1 =/= K
      andBool E2 =/= K
      andBool EDelete =/= K

*** lemmaListContainsUnsafeToInKeys(K, L1)
  -- NAMED-LEMMA-LIST-CONTAINS-UNSAFE-TO-IN-KEYS-SYNTAX
  -- TRUSTED-LIST-CONTAINS-UNSAFE-TO-IN-KEYS
  ==> #listContainsUnsafe(L1, K) ==K K in_keys(listToMapSet(L1))
*** lemmaListContainsUnsafeToInKeys(K, L2)
  ==> #listContainsUnsafe(L2, K) ==K K in_keys(listToMapSet(L2))
*** lemmaInKeysSubstitution
        ( K
        , listToMapSet(L1)[E2 <- 0][EDelete <- undef]
        , K
        , listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        , true
        )
    -- NAMED-LEMMA-IN-KEYS-SUBSTITUTION-SYNTAX
    -- TRUSTED-IN-KEYS-SUBSTITUTION
    ==> K in_keys(listToMapSet(L1)[E2 <- 0][EDelete <- undef])
          == K in_keys(listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef])
        *** LEMMA-IN-KEYS-SQUARE-BRACKET-UNDEF
        K in_keys(listToMapSet(L1)[E2 <- 0])
          == K in_keys(listToMapSet(L2)[E1 <- 0][E2 <- 0])
        K in_keys(listToMapSet(L1))
          == K in_keys(listToMapSet(L2)[E1 <- 0])
        K in_keys(listToMapSet(L1))
          == K in_keys(listToMapSet(L2))

*/
