// breadth = 1
//@ proof
require "../../0/signers/trusted-count-can-sign-map.k"  //@ Bazel remove

module LEMMA-COUNT-CAN-SIGN-MAP
  imports K-EQUAL-SYNTAX
  imports TRUSTED-COUNT-CAN-SIGN-MAP
//@ trusted
// require "protocol-correctness/lib/functions/bool-to-int.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-elements-are-usize.k"
// require "protocol-correctness/lib/functions/map-values-are-kresult.k"
// require "protocol-correctness/lib/functions/map-values-are-of-type.k"
// require "protocol-correctness/multisig/lib/functions/can-sign-function.k"
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// require "protocol-correctness/multisig/lib/language/type-reflection.k"
// //
// module TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP
//@ end

  imports BOOL-TO-INT-SYNTAX
  imports CAN-SIGN-FUNCTION-SYNTAX
  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports LIST-CONTAINS-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports MULTISIG-TYPE-REFLECTION-SYNTAX

  lemma
      nop
      // TODO: This can't be prove directly because that would require
      // the Haskell backend to send something like
      // `f(x) + 1 ==K g(x) + 1` and `not f(x) == g(x)` to z3, where
      // `f` and `g` are not total functions, although they are defined
      // in the current context.
      //
      // Probably this will be fixed at some point, in which case this should
      // be proven directly, without the lemma below.
      ~> lemmaCountCanSignMap(
            Es:ExpressionCSV,
            UserId:Usize,
            Role:UserRole,
            M:Map,
            0
        )
      => .K
    proves
      countCanSignFunction( [ Es:ExpressionCSV ], UserId:Usize |-> Role:UserRole M:Map )
      => boolToInt(canSignFunction(Role) andBool #listContainsSafe([Es], UserId))
        +Int countCanSignFunction([ Es ], M)
    requires
      true
      andBool isKResult(UserId)
      andBool isKResultExpressionCSV(Es)
      andBool notBool (UserId in_keys(M))
      andBool mapValuesAreKResult(M)
      andBool mapValuesAreOfType(M, rUserRole)
      andBool listElementsAreUsize([Es])
    [simplification]
    endlemma

endmodule

