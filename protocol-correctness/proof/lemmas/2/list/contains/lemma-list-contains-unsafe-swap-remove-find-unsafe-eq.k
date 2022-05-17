// breadth = 5
//@ proof
module LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-EQ
  imports INDUCTION-SYNTAX
  imports K-EQUAL-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-elements-are-distinct.k"
// require "protocol-correctness/lib/functions/list-find.k"
// require "protocol-correctness/lib/functions/list-swap-remove.k"
// //
// module TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-EQ
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-ELEMENTS-ARE-DISTINCT-ADDITIONAL-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX

  lemma
      induction(
        case "es" of
          | . -> .Induction .
          | "e1" <> "es1" ->
            case $#listFindUnsafe("es", "e") of
              | < 0 -> .Induction .
              | >= 0 ->
                case "e1" == "e" of
                  | True -> .Induction .
                  | False ->
                    case $#listFindUnsafe("es", "e") of
                      | < 0 -> .Induction .
                      | >= 0 -> reinduction("e", "es1") .
                    esac
                    .
                esac
                .
            esac
            .
        esac,
        ("e", E:Expression)
          <> ("es", Es:ExpressionCSV)
      ) => .K
    proves
      #listContainsUnsafe
        ( [ #listSwapRemove(Es:ExpressionCSV, #listFindUnsafe([Es], E)) ]
        , E:Expression
        )
      => false
    requires
      true
      andBool listElementsAreDistinctUnsafe([Es])
    [simplification]
    endlemma

endmodule
/*
#listContainsUnsafe
    ( [ #listSwapRemove(Es, #listFindUnsafe([Es], E)) ]
    , E
    )
  => false
  requires listElementsAreDistinctUnsafe([Es])

case Es of
  . ->
    #listContainsUnsafe
        ( [ #listSwapRemove(., #listFindUnsafe([.], E)) ]
        , E
        )
      => false
      requires listElementsAreDistinctUnsafe([.])
    #listContainsUnsafe
        ( [ #listSwapRemove(., -1 ]
        , E
        )
      => false
      requires true
    #listContainsUnsafe
        ( [ . ]
        , E
        )
      => false
    ok

  E1 <> Es1 ->
    #listContainsUnsafe
        ( [ #listSwapRemove((E1, Es1), #listFindUnsafe([E1, Es1], E)) ]
        , E
        )
      => false
      requires listElementsAreDistinctUnsafe([E1, Es])
    #listContainsUnsafe
        ( [ #listSwapRemove((E1, Es1), #listFindUnsafe([E1, Es1], E)) ]
        , E
        )
      => false
      requires true
          andBool notBool #listContainsUnsafe([Es1], E1)
          andBool listElementsAreDistinctUnsafe([Es1])
    case #listFindUnsafe([E1, Es1], E) of
      < 0 ->
        #listContainsUnsafe( [ E1, Es1 ], E )
          => false
          requires true
              andBool notBool #listContainsUnsafe([Es1], E1)
              andBool listElementsAreDistinctUnsafe([Es1])
              andBool #listFindUnsafe( [ E1, Es1 ], E ) < 0
        *** TRUSTED-LEMMA-LIST-CONTAINS-FALSE-LIST-FIND
      >= 0 ->
        #listContainsUnsafe
            ( [ #listSwapRemove((E1, Es1), #listFindUnsafe([E1, Es1], E)) ]
            , E
            )
          => false
          requires true
              andBool notBool #listContainsUnsafe([Es1], E1)
              andBool listElementsAreDistinctUnsafe([Es1])
              andBool #listFindUnsafe([E1, Es1], E) >= 0
        case E1 == E of
          True ->
            #listContainsUnsafe
                ( [ #listSwapRemove((E, Es1), #listFindUnsafe([E, Es1], E)) ]
                , E
                )
              => false
              requires true
                  andBool notBool #listContainsUnsafe([Es1], E)
                  andBool listElementsAreDistinctUnsafe([Es1])
                  andBool #listFindUnsafe([E, Es1], E) >= 0
            #listContainsUnsafe
                ( [ #listSwapRemove((E, Es1), 0) ]
                , E
                )
              => false
              requires true
                  andBool notBool #listContainsUnsafe([Es1], E)
                  andBool listElementsAreDistinctUnsafe([Es1])
                  andBool 0 >= 0
            #listContainsUnsafe( [ lastToStart(Es1) ], E )
              => false
              requires true
                  andBool notBool #listContainsUnsafe([Es1], E)
                  andBool listElementsAreDistinctUnsafe([Es1])
            *** LEMMA-LIST-CONTAINS-LAST-TO-START
          False ->
            #listContainsUnsafe
                ( [ #listSwapRemove((E1, Es1), #listFindUnsafe([E1, Es1], E)) ]
                , E
                )
              => false
              requires true
                  andBool notBool #listContainsUnsafe([Es1], E1)
                  andBool listElementsAreDistinctUnsafe([Es1])
                  andBool #listFindUnsafe([E1, Es1], E) >= 0
                  andBool E1 =/= E
            #listContainsUnsafe
                ( [ #listSwapRemove
                      ( (E1, Es1)
                      , addOneIfNotNegative(#listFindUnsafe([Es1], E))
                      )
                  ]
                , E
                )
              => false
              requires true
                  andBool notBool #listContainsUnsafe([Es1], E1)
                  andBool listElementsAreDistinctUnsafe([Es1])
                  andBool addOneIfNotNegative(#listFindUnsafe([Es1], E)) >= 0
                  andBool E1 =/= E
            case #listFindUnsafe([Es1], E) of
              < 0 -> Ok.
              >= 0 ->
                #listContainsUnsafe
                    ( [ #listSwapRemove
                          ( (E1, Es1)
                          , addOneIfNotNegative(#listFindUnsafe([Es1], E))
                          )
                      ]
                    , E
                    )
                  => false
                  requires true
                      andBool notBool #listContainsUnsafe([Es1], E1)
                      andBool listElementsAreDistinctUnsafe([Es1])
                      andBool addOneIfNotNegative(#listFindUnsafe([Es1], E)) >= 0
                      andBool E1 =/= E
                      andBool #listFindUnsafe([Es1], E) >= 0
                #listContainsUnsafe
                    ( [ #listSwapRemove
                          ( (E1, Es1)
                          , #listFindUnsafe([Es1], E) + 1
                          )
                      ]
                    , E
                    )
                  => false
                  requires true
                      andBool notBool #listContainsUnsafe([Es1], E1)
                      andBool listElementsAreDistinctUnsafe([Es1])
                      andBool #listFindUnsafe([Es1], E) + 1 >= 0
                      andBool E1 =/= E
                      andBool #listFindUnsafe([Es1], E) >= 0
                #listContainsUnsafe
                    ( [ E1
                      , #listSwapRemove
                          ( Es1
                          , #listFindUnsafe([Es1], E)
                          )
                      ]
                    , E
                    )
                  => false
                  requires true
                      andBool notBool #listContainsUnsafe([Es1], E1)
                      andBool listElementsAreDistinctUnsafe([Es1])
                      andBool E1 =/= E
                      andBool #listFindUnsafe([Es1], E) >= 0
                #listContainsUnsafe
                    ( [ #listSwapRemove( Es1, #listFindUnsafe([Es1], E) ) ]
                    , E
                    )
                  => false
                  requires true
                      andBool notBool #listContainsUnsafe([Es1], E1)
                      andBool listElementsAreDistinctUnsafe([Es1])
                      andBool E1 =/= E
                      andBool #listFindUnsafe([Es1], E) >= 0
                *** induction ***

*/
