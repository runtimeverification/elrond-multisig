// timeout = long
// breadth = 12
//@ proof
module LEMMA-AT-MOST-THIS-SIGNER-0-COUNT-CAN-SIGN-FUNCTION
  imports INDUCTION-SYNTAX
  imports K-EQUAL
//@ trusted
// require "protocol-correctness/lib/functions/list-elements-are-usize.k"
// require "protocol-correctness/lib/functions/map-values-are-kresult.k"
// require "protocol-correctness/lib/functions/map-values-are-of-type.k"
// require "protocol-correctness/lib/language/base-types.k"
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// require "protocol-correctness/multisig/lib/functions/pound-at-most-this-signer-list.k"
// require "protocol-correctness/multisig/lib/language/type-reflection.k"
// //
// module TRUSTED-LEMMA-AT-MOST-THIS-SIGNER-0-COUNT-CAN-SIGN-FUNCTION
//@ end

  imports BASE-TYPES-SYNTAX
  imports BOOL
  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
  imports MAP
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports MULTISIG-TYPE-REFLECTION-SYNTAX
  imports POUND-AT-MOST-THIS-SIGNER-LIST-ADDITIONAL-SYNTAX

  lemma
      induction(
        case "es" of
          | . -> .Induction .
          | "e1" <> "es1" ->
            call $castNoValue("e1", $rUsize())
            ~~> case "u" == "e1" of
              | True ->
                case "m" key "e1" of
                  | . -> reinduction("u", "es1", "m") .
                  | "m1"["k1" <- "v1"] ->
                    call $castNoValue("v1", $rUserRole())
                    ~~> call $concretizeValue("v1")
                    ~~> reinduction("u", "es1", "m")
                    .
                esac
                .
              | False ->
                case "m" key "e1" of
                  | . -> reinduction("u", "es1", "m") .
                  | "m1"["k1" <- "v1"] ->
                    call $castNoValue("v1", $rUserRole())
                    ~~> call $concretizeValue("v1")
                    ~~> reinduction("u", "es1", "m")
                    .
                esac
                .

            esac
            .
        esac,
        ("u", U:Usize) <> ("es", Es:ExpressionCSV) <> ("m", UserIdToRole:Map)
      ) => .K
    proves
      #atMostThisSignerList(U:Usize, [Es:ExpressionCSV], UserIdToRole:Map) => true
    requires
      true
      andBool countCanSignFunction([Es], UserIdToRole) ==Int 0
      andBool listElementsAreUsize([Es])
      andBool isKResult([Es])
      andBool mapValuesAreOfType(UserIdToRole, rUserRole)
      andBool mapValuesAreKResult(UserIdToRole)
    [simplification]
    endlemma

endmodule