// timeout = moderate
// breadth = 3
//@ proof
require "../../../lemmas-0/map/square-bracket/trusted-commute-square-bracket-assignment-same-value.k"  //@ Bazel remove
require "../../../lemmas-0/map/square-bracket/trusted-square-bracket-substitution.k"  //@ Bazel remove
require "../../../lemmas-0/equality/trusted-equality-transitivity.k"  //@ Bazel remove

module LEMMA-LIST-TO-MAP-SET-POUND-REMOVE-LAST-POUND-LAST
  imports INDUCTION-SYNTAX
  imports K-EQUAL
  imports TRUSTED-COMMUTE-SQUARE-BRACKET-ASSIGNMENT-SAME-VALUE
  imports TRUSTED-SQUARE-BRACKET-SUBSTITUTION

//@ trusted
// require "protocol-correctness/lib/last-functions.k"
// require "protocol-correctness/lib/list-to-map-set.k"
// require "protocol-correctness/lib/remove-last.k"
// 
// module TRUSTED-LEMMA-LIST-TO-MAP-SET-POUND-REMOVE-LAST-POUND-LAST
//@ end

  imports LAST-FUNCTIONS-ADDITIONAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports REMOVE-LAST-ADDITIONAL-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" ->
              call $lemmaCommuteMapSquareBracketAssignmentSameValue(
                    $listToMapSet($expressionList($#removeLast("e1", "es1"))),
                    "e",
                    $#last("e1", "es1"),
                    0
                  )
              ~~> case
                    $mapUpdate(
                      $listToMapSet($expressionList($#removeLast("e1", "es1"))),
                      $#last("e1", "es1"),
                      0
                    )
                    ==
                    $mapUpdate(
                      $listToMapSet($expressionList("es1")),
                      "e1",
                      0
                    )
                  of
                    | False -> reinduction("e1", "es1") .
                    | True ->
                        call $lemmaSquareBracketSubstitution(
                          $mapUpdate(
                            $listToMapSet($expressionList($#removeLast("e1", "es1"))),
                            $#last("e1", "es1"),
                            0
                          ),
                          "e",
                          0,
                          $mapUpdate(
                            $listToMapSet($expressionList("es1")),
                            "e1",
                            0
                          ),
                          "e",
                          0,
                          true
                        )
                        .
                  esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      listToMapSet([#removeLast(E:Expression, Es:ExpressionCSV)])[#last(E, Es) <- 0]
      => listToMapSet([Es])[E <- 0]
    requires
      true
    [simplification]
    endlemma

endmodule
