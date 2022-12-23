// breadth = 3
//@ proof
module LEMMA-LIST-CONTAINS-FALSE-LIST-FIND
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-find.k"
// 
// module TRUSTED-LEMMA-LIST-CONTAINS-FALSE-LIST-FIND
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX

  lemma
      induction(
          case "es" of
            | . -> .Induction .
            | "e1" <> "es1" ->
              case "e" == "e1" of
                | True -> .Induction .
                | False ->
                  case $#listFindUnsafe("es1", "e") of
                    | >= 0 -> .Induction .
                    | < 0 -> reinduction("e", "es1") .
                  esac
                  .
              esac
              .
          esac,
          ("e", E:Expression) <> ("es", Es:ExpressionCSV)
        )
      => .K
    proves
      #listContainsUnsafe([Es:ExpressionCSV], E:Expression) => false
    requires
      #listFindUnsafe([Es], E) <Int 0
    [simplification]
    endlemma

endmodule

/*
#listContainsUnsafe([Es], E) => false
  requires true
    andBool #listFindUnsafe([Es], E) <Int 0

case es of
  . ->
    #listContainsUnsafe([.], E) => false
      requires true
        andBool #listFindUnsafe([.], E) <Int 0
    ok
  e1 <> es1 ->
    #listContainsUnsafe([E1, Es1], E) => false
      requires true
        andBool #listFindUnsafe([E1, Es1], E) <Int 0
    case e1 == e of
      True ->
        #listContainsUnsafe([E, Es1], E) => false
          requires true
            andBool #listFindUnsafe([E, Es1], E) <Int 0
        true => false
          requires true
            andBool 0 <Int 0
        ok
      False ->
        #listContainsUnsafe([E1, Es1], E) => false
          requires true
            andBool #listFindUnsafe([E1, Es1], E) <Int 0
            andBool E1 =/= E
        #listContainsUnsafe([Es1], E) => false
          requires true
            andBool addOneIfNotNegative(#listFindUnsafe([Es1], E)) <Int 0
            andBool E1 =/= E
        case #listFindUnsafe([Es1], E) of
          >= 0 ->
            #listContainsUnsafe([Es1], E) => false
              requires true
                andBool addOneIfNotNegative(#listFindUnsafe([Es1], E)) <Int 0
                andBool E1 =/= E
                andBool #listFindUnsafe([Es1], E) >= 0
            #listContainsUnsafe([Es1], E) => false
              requires true
                andBool #listFindUnsafe([Es1], E) + 1 <Int 0
                andBool E1 =/= E
                andBool #listFindUnsafe([Es1], E) >= 0
            ok
          < 0 ->
            #listContainsUnsafe([Es1], E) => false
              requires true
                andBool addOneIfNotNegative(#listFindUnsafe([Es1], E)) <Int 0
                andBool E1 =/= E
                andBool #listFindUnsafe([Es1], E) < 0
            #listContainsUnsafe([Es1], E) => false
              requires true
                andBool #listFindUnsafe([Es1], E) <Int 0
                andBool E1 =/= E
                andBool #listFindUnsafe([Es1], E) < 0
            *** induction
*/
