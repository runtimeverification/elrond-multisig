// breadth = 1
//@ proof
module LEMMA-LIST-TO-MAP-SET-LIST-SWAP-REMOVE-LIST-FIND-DELETE
  imports INDUCTION-SYNTAX
  imports K-EQUAL

//@ trusted
// require "protocol-correctness/lib/list-find.k"
// require "protocol-correctness/lib/list-swap-remove.k"
// require "protocol-correctness/lib/list-to-map-set.k"
// 
// module TRUSTED-LEMMA-LIST-TO-MAP-SET-LIST-SWAP-REMOVE-LIST-FIND-DELETE
//@ end

  imports LIST-FIND-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" ->
              case $#listFind("es", "e") of
                | < 0 -> .Induction .
                | = 0 -> .Induction .
                | > 0 ->
                  case "e" == "e1" of
                    | True -> .Induction .
                    | False ->
                      call $lemmaCommuteMapSquareBracketAssignmentDelete(
                              $listToMapSet("es1"), "e1", 0, "e")
                      ~~> call $lemmaCommuteMapSquareBracketAssignmentDelete(
                              $listToMapSet(
                                  $listSwapRemove("es1", $#listFind("es1", "e")
                              ),
                              "e1", 0, "e"
                          )
                      ~~> case  $mapDelete(
                                    $listToMapSet(
                                        $listSwapRemove(
                                            "es1", $#listFind("es1", "e"
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
                                            $listSwapRemove(
                                                "es1", $#listFind("es1", "e"
                                            )
                                        )
                                        , "e"
                                    ),
                                    "e1", 0,
                                    $mapDelete($listToMapSet("es1"), "e"),
                                    "e1", 0
                                ) .
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
      listToMapSet([#listSwapRemove(Es, #listFind([Es], E))])[E <- undef]
      => listToMapSet([L])[E <- undef]
    requires
      true
    [simplification]
    endlemma

endmodule
