// breadth = 2
//@ proof
module LEMMA-LIST-CONTAINS-UNSAFE-ELEMENT-LAST-TO-START
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/last-to-start.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// //
// module TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-ELEMENT-LAST-TO-START
//@ end

  imports LAST-TO-START-SYNTAX
  imports LIST-CONTAINS-ADDITIONAL-SYNTAX

  lemma
      induction(
        case "e" == "e1" of
          | False -> .Induction .
          | True -> .Induction .
        esac,
        ("e", E:Expression)
            <> ("e1", E1:Expression)
            <> ("es", Es:ExpressionCSV)
      ) => .K
    proves
      #listContainsUnsafe
        ( [ E1:Expression, lastToStart(Es:ExpressionCSV) ]
        , E:Expression 
        )
      => #listContainsUnsafe([E1, Es], E)
    requires
      true
    [simplification]
    endlemma

endmodule

/*
#listContainsUnsafe([E1, lastToStart(Es)], E)
    ==K #listContainsUnsafe([E1, Es], E)
case E1 ==K E
  true:
    true ==K true
  false:
    #listContainsUnsafe([lastToStart(Es)], E)
        ==K #listContainsUnsafe([Es], E)
    LEMMA-LIST-CONTAINS-LAST-TO-START
*/