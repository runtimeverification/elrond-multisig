// breadth = 2
//@ proof
module PROOF-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3
//@ trusted
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// require "protocol-correctness/proof/named-lemmas/count-can-sign-list-to-map-set-square-bracket-3.k"
// module TRUSTED-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3
//@ end

  imports BOOL
  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports K-EQUAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3-SYNTAX

  claim
      lemmaCountCanSignListToMapSetSquareBracket3(
          L1:ExpressionList,
          L2:ExpressionList,
          M:Map,
          E1:Expression,
          E2:Expression,
          EDelete:Expression)
      => .K
    requires true
      andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
          ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
      andBool notBool E1 in_keys(M)
      andBool notBool E2 in_keys(M)
      andBool notBool EDelete in_keys(M)
    ensures
      countCanSignFunction(L1, M) ==K countCanSignFunction(L2, M)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
