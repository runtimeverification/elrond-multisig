// breadth = 3
//@ proof
module LEMMA-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// //
// module TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports K-EQUAL-SYNTAX

  lemma
      induction(
        case "es" of
          | . -> .Induction .
          | "e1" <> "es1" ->
            case "e" == "e1" of
              | True -> .Induction .
              | False -> reinduction("e", "es1") .
            esac
            .
        esac,
        ("e", E:Expression) <> ("es", Es:ExpressionCSV)
      ) => .K
    proves
      #listContainsUnsafe( [ Es:ExpressionCSV ], E:Expression )
      => true
    requires
      E in_keys(listToMapSet([ Es ]))
    [simplification]
    endlemma

endmodule

/*

#listContainsUnsafe(L, E) => true
  requires
    E in listToMapSet(L)

case L of
  . ->
    #listContainsUnsafe(., E) => true
      requires
        E in listToMapSet(.)
    false => true
      requires
        E in .Map
    ok.
  E1 <> L1 ->
    #listContainsUnsafe(E1 <> L1, E) => true
      requires
        E in listToMapSet(E1 <> L1)
    #listContainsUnsafe(E1 <> L1, E) => true
      requires
        E in listToMapSet(L1)[E1 <- 0]
    case E == E1 of
      True ->
        #listContainsUnsafe(E <> L1, E) => true
          requires
            E in listToMapSet(L1)[E <- 0]
        true => true
          requires
            true
        ok.
      False ->
        #listContainsUnsafe(E1 <> L1, E) => true
          requires
            E in listToMapSet(L1)[E1 <- 0]
            andBool E =/= E1
        #listContainsUnsafe(L1, E) => true
          requires
            E in listToMapSet(L1)
            andBool E =/= E1
        induction


*/
