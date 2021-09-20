// timeout = moderate
// breadth = 3
//@ proof
require "../../../0/map/square-bracket/trusted-commute-square-bracket.k"  //@ Bazel remove
require "../../../0/map/square-bracket/trusted-square-bracket-substitution.k"  //@ Bazel remove
require "../../../0/equality/trusted-equality-transitivity.k"  //@ Bazel remove

module LEMMA-LIST-TO-MAP-SET-LAST-TO-START
  imports INDUCTION-SYNTAX
  imports K-EQUAL
  imports TRUSTED-COMMUTE-SQUARE-BRACKET
  imports TRUSTED-SQUARE-BRACKET-SUBSTITUTION

//@ trusted
// require "protocol-correctness/lib/functions/last-to-start.k"
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// 
// module TRUSTED-LEMMA-LIST-TO-MAP-SET-LAST-TO-START
//@ end

  imports LAST-TO-START-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" -> reinduction("e1", "es1") .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      listToMapSet([lastToStart(Es:ExpressionCSV)])
      => listToMapSet([Es])
    requires
      true
    [simplification]
    endlemma

endmodule
