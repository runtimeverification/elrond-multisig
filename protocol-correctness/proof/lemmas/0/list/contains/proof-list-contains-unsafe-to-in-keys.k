// breadth = 3
//@ proof
module PROOF-LIST-CONTAINS-UNSAFE-TO-IN-KEYS
//@ trusted
// module TRUSTED-LIST-CONTAINS-UNSAFE-TO-IN-KEYS
//@ end

  imports K-EQUAL-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-TO-IN-KEYS-SYNTAX

  claim
      lemmaListContainsUnsafeToInKeys(E:KItem, Es:ExpressionCSV)
      => .K
    requires true
    ensures
      #listContainsUnsafe([Es], E) ==K (E in_keys(listToMapSet([Es])))
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule

/*
#listContainsUnsafe(L, K) ==K K in_keys(listToMapSet(L))

case L of
  . ->
    #listContainsUnsafe(., K) ==K K in_keys(listToMapSet(.))
    false ==K K in_keys(.Map)
    ok.
  e1 <> es1 ->
    #listContainsUnsafe(e1 <> es1, K) ==K K in_keys(listToMapSet(e1 <> es1))
    #listContainsUnsafe(e1 <> es1, K) ==K K in_keys(listToMapSet(es1)[e1 <- 0])
    case e1 == k of
      True ->
        #listContainsUnsafe(K <> es1, K) ==K K in_keys(listToMapSet(es1)[K <- 0])
        ok.
      False ->
        #listContainsUnsafe(e1 <> es1, K) ==K K in_keys(listToMapSet(es1)[e1 <- 0])
          requires
            andBool E1 =/= K
        #listContainsUnsafe(es1, K) ==K K in_keys(listToMapSet(es1))
          requires
            andBool E1 =/= K
        induction(K, Es)
 */
