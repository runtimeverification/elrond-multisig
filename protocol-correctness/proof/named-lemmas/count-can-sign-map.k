require "protocol-correctness/lib/language/base-types.k"
require "protocol-correctness/lib/proof/induction/syntax.k"
require "protocol-correctness/multisig/lib/language/syntax.k"

module NAMED-LEMMA-COUNT-CAN-SIGN-MAP-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports MAP
  imports MULTISIG-SYNTAX

  syntax KItem ::= lemmaCountCanSignMap(
                        signers:ExpressionCSV,
                        userId:Usize,
                        role:UserRole,
                        userIdToRole:Map,
                        delta:Int
                    )
endmodule

module NAMED-LEMMA-COUNT-CAN-SIGN-MAP
  imports NAMED-LEMMA-COUNT-CAN-SIGN-MAP-SYNTAX

  imports INDUCTION-SYNTAX

  rule lemmaCountCanSignMap(
            Es:ExpressionCSV,
            UserId:Usize,
            Role:UserRole,
            UserIdToRole:Map,
            Delta:Int
        )
    =>     
      induction(
        case "es" of
          | . -> .Induction .
          | "e1" <> "es1" ->
            call $castNoValue("e1", $rUsize())
            ~~> case "e1" == "userid" of
              | True -> call $concretizeValue("role") .
              | False ->
                case "m" key "e1" of
                  | . ->
                    call $lemmaCountCanSignMap("es1", "userid", "role", "m", "delta")
                    .
                  | "m1" ["k" <- "v"] ->
                    call $castNoValue("v", $rUserRole())
                    ~~> case $canSignFunction("v") of
                      | False ->
                          call $concretizeValue("v")
                          ~~> call $lemmaCountCanSignMap
                                      ("es1", "userid", "role", "m1", "delta")
                          .
                      | True ->
                          call $lemmaCountCanSignMap
                                  ("es1", "userid", "role", "m1", "delta" + 1)
                          .
                    esac
                    .
                esac
                .
            esac
            .
        esac,
        ("es", Es)
            <> ("userid", UserId)
            <> ("role", Role)
            <> ("m", UserIdToRole)
            <> ("delta", Delta)
      )

  rule  reflectionApply($lemmaCountCanSignMap,
            ( reflectionArgument(Es:ExpressionCSV)
            , reflectionArgument(UserId:Usize)
            , reflectionArgument(Role:UserRole)
            , reflectionArgument(UserIdToRole:Map)
            , reflectionArgument(Delta:Int)
            )
        )
    => lemmaCountCanSignMap(Es, UserId, Role, UserIdToRole, Delta)
endmodule
