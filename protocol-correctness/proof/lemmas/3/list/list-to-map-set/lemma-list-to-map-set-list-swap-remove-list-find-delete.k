// timeout = moderate
// breadth = 6
//@ proof
require "../../../0/map/square-bracket/trusted-commute-square-bracket.k"  //@ Bazel remove
require "../../../0/map/square-bracket/trusted-square-bracket-substitution.k"  //@ Bazel remove

module LEMMA-LIST-TO-MAP-SET-LIST-SWAP-REMOVE-LIST-FIND-DELETE
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
  imports TRUSTED-COMMUTE-SQUARE-BRACKET
  imports TRUSTED-SQUARE-BRACKET-SUBSTITUTION

//@ trusted
// require "protocol-correctness/lib/functions/list-find.k"
// require "protocol-correctness/lib/functions/list-swap-remove.k"
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// 
// module TRUSTED-LEMMA-LIST-TO-MAP-SET-LIST-SWAP-REMOVE-LIST-FIND-DELETE
//@ end

  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" ->
              case "e" == "e1" of
                | True -> .Induction .
                | False -> .Induction .
              esac
              ~~> case $#listFindUnsafe("es", "e") of
                | < 0 ->
                  // TODO: This should not be needed, Haskell backend bug
                  case "es1" of
                    | . -> .Induction .
                    | "e2" <> "es2" -> .Induction .
                  esac .
                | = 0 -> .Induction .
                | > 0 ->
                  call $lemmaCommuteMapSquareBracketAssignmentDelete(
                          $listToMapSet("es1"), "e1", 0, "e")
                  ~~> call $lemmaCommuteMapSquareBracketAssignmentDelete(
                          $listToMapSet(
                              $#listSwapRemove("es1", $#listFindUnsafe("es1", "e"))
                          ),
                          "e1", 0, "e"
                      )
                  ~~> case  $mapDelete(
                                $listToMapSet(
                                    $#listSwapRemove(
                                        "es1", $#listFindUnsafe("es1", "e")
                                    )
                                )
                                , "e"
                            )
                            ==
                            $mapDelete($listToMapSet("es1"), "e")
                      of
                        | False -> reinduction("e", "es1") .
                        | True ->
                            call $lemmaSquareBracketSubstitution(
                                $mapDelete(
                                    $listToMapSet(
                                        $#listSwapRemove(
                                            "es1", $#listFindUnsafe("es1", "e")
                                        )
                                    )
                                    , "e"
                                ),
                                "e1", 0,
                                $mapDelete($listToMapSet("es1"), "e"),
                                "e1", 0,
                                true
                            )
                            // TODO: This should not be needed, Haskell backend bug
                            ~~> case "es1" of
                                | . -> .Induction .
                                | "e2" <> "es2" -> .Induction .
                              esac
                            .
                      esac
                  .
              esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      listToMapSet([#listSwapRemove(Es, #listFindUnsafe([Es], E))])[E <- undef]
      => listToMapSet([Es])[E <- undef]
    requires
      true
    [simplification]
    endlemma

endmodule
