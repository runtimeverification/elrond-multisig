// breadth = 4
// timeout = moderate
//@ proof
require "../../../0/map/square-bracket/trusted-commute-square-bracket.k"  //@ Bazel remove
require "../../../0/map/square-bracket/trusted-square-bracket-substitution.k"  //@ Bazel remove

module LEMMA-LIST-TO-MAP-SET-LIST-SWAP-REMOVE-LIST-FIND-SQ-B-SQ-B-SQ-B-DELETE
  imports INDUCTION-SYNTAX
  imports K-EQUAL
  imports TRUSTED-COMMUTE-SQUARE-BRACKET
  imports TRUSTED-SQUARE-BRACKET-SUBSTITUTION

//@ trusted
// require "protocol-correctness/lib/list-find.k"
// require "protocol-correctness/lib/list-swap-remove.k"
// require "protocol-correctness/lib/list-to-map-set.k"
// 
// module TRUSTED-LIST-TO-MAP-SET-LIST-SWAP-REMOVE-LIST-FIND-SQ-B-SQ-B-SQ-B-DELETE
//@ end

  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX

  lemma
      induction(
          case "k2" == "e" of
            | True ->
              case "k1" == "e" of
                | True -> .Induction .
                | False ->
                  call $lemmaCommuteMapSquareBracketAssignmentDelete(
                      $listToMapSet($#listSwapRemove("es", $#listFindUnsafe("es", "e"))),
                      "k1", "v", "e"
                  )
                  ~~> call $lemmaCommuteMapSquareBracketAssignmentDelete(
                      $listToMapSet("es"), "k1", "v", "e"
                  )
                  .
              esac
              .
            | False ->
              call $lemmaCommuteMapSquareBracketAssignmentDelete(
                  $mapUpdate(
                    $listToMapSet($#listSwapRemove("es", $#listFindUnsafe("es", "e"))),
                    "k1", "v"
                  ),
                  "k2", "v", "e"
              )
              ~~> call $lemmaCommuteMapSquareBracketAssignmentDelete(
                  $mapUpdate($listToMapSet("es"), "k1", "v"),
                  "k2", "v", "e"
              )
              ~~> case "k1" == "e" of
                | True -> .Induction .
                | False ->
                  call $lemmaCommuteMapSquareBracketAssignmentDelete(
                      $listToMapSet($#listSwapRemove("es", $#listFindUnsafe("es", "e"))),
                      "k1", "v", "e"
                  )
                  ~~> call $lemmaCommuteMapSquareBracketAssignmentDelete(
                      $listToMapSet("es"), "k1", "v", "e"
                  )
                  ~~> call $lemmaSquareBracketSubstitution(
                      $mapDelete(
                        $mapUpdate(
                          $listToMapSet(
                            $#listSwapRemove("es", $#listFindUnsafe("es", "e"))
                          ),
                          "k1", "v"
                        ),
                        "e"
                      ),
                      "k2", "v",
                      $mapDelete(
                        $mapUpdate($listToMapSet("es"), "k1", "v"),
                        "e"
                      ),
                      "k2", "v",
                      true
                  )
                  .
              esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
          <> ("k1", K1:KItem)<> ("k2", K2:KItem)<> ("v", V:KItem)
        )
      => .K
    proves
      listToMapSet([#listSwapRemove(
                      Es:ExpressionCSV, #listFindUnsafe([Es], E:Expression))
                    ])
          [K1:KItem <- V:KItem][K2 <- V][E <- undef]
      => listToMapSet([Es])[K1 <- V][K2 <- V][E <- undef]
    requires
      true
    [simplification]
    endlemma

endmodule
