// breadth = 2
//@ proof
require "../../../0/map/square-bracket/trusted-commute-square-bracket.k"  //@ Bazel remove

module LEMMA-SQUARE-BRACKET-SQ-B-SQ-B-UNDEF
  imports INDUCTION-SYNTAX
  imports K-EQUAL
  imports TRUSTED-COMMUTE-SQUARE-BRACKET

//@ trusted
// require "protocol-correctness/lib/functions/last-functions.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// 
// module TRUSTED-LEMMA-SQUARE-BRACKET-SQ-B-SQ-B-UNDEF
//@ end

  imports BOOL
  imports MAP

  lemma
      induction(
          case "k" == "k1" of
            | True -> .Induction .
            | False -> 
              call $lemmaCommuteMapSquareBracketAssignmentDelete(
                $mapUpdate("m", "k", "v"), "k1", "v1", "k")
              ~~> call $lemmaCommuteMapSquareBracketAssignmentDelete(
                "m", "k1", "v1", "k")
              .
          esac
          , ("m", M:Map)
            <> ("k", K:KItem) <> ("v", V:KItem)
            <> ("k1", K1:KItem) <> ("v1", V1:KItem)
        )
      => .K
    proves
      M:Map[K:KItem <- V:KItem][K1:KItem <- V1:KItem][K <- undef]
      => M[K1:KItem <- V1:KItem][K <- undef]
    requires
      true
    [simplification]
    endlemma

endmodule
