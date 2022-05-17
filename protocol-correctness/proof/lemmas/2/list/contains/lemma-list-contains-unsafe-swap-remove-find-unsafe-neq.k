// breadth = 5
//@ proof
module LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-NEQ
  imports INDUCTION-SYNTAX
//@ trusted
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-find.k"
// require "protocol-correctness/lib/functions/list-swap-remove.k"
// //
// module TRUSTED-LEMMA-LIST-CONTAINS-UNSAFE-SWAP-REMOVE-FIND-UNSAFE-NEQ
//@ end

  imports LIST-CONTAINS-ADDITIONAL-SYNTAX
  imports LIST-FIND-ADDITIONAL-SYNTAX
  imports LIST-SWAP-REMOVE-SYNTAX
  imports K-EQUAL-SYNTAX

  lemma
      induction(
        case "es" of
          | . -> .Induction .
          | "e1" <> "es1" ->
            case "e1" == "er" of
              | True -> .Induction .
              | False ->
                case $#listFindUnsafe("es1", "er") of
                  | < 0 -> .Induction .
                  | >= 0 ->
                    case "e" == "e1" of
                      | True -> .Induction .
                      | False -> reinduction("e", "er", "es1") .
                    esac .
                esac .
            esac .
        esac,
        ("e", E:Expression)
          <> ("er", Er:Expression)
          <> ("es", Es:ExpressionCSV)
      ) => .K
    proves
      #listContainsUnsafe
        ( [ #listSwapRemove(Es:ExpressionCSV, #listFindUnsafe([Es], Er)) ]
        , E:Expression 
        )
      => #listContainsUnsafe([Es], E)
    requires
      true
      andBool E =/=K Er
    [simplification]
    endlemma

endmodule

/*

  #listContainsUnsafe([#listSwapRemove(Es, #listFindUnsafe([Es], Er))], E)
      => #listContainsUnsafe([Es], E)
    requires E =/= Er
  case es:
    . -> ok
    E1, Es1 ->
      #listContainsUnsafe([#listSwapRemove(E1, Es1, #listFindUnsafe([E1, Es1], Er))], E)
          => #listContainsUnsafe([E1, Es1], E)
        requires E =/= Er
      case E1 == Er:
        True ->
          #listContainsUnsafe
                  ( [ #listSwapRemove(Er, Es1, 0 ) ]
                  , E
                  )
              => #listContainsUnsafe([Er, Es1], E)
            requires E =/= Er
          #listContainsUnsafe
                  ( [ lastToStart(Es1) ]
                  , E
                  )
              => #listContainsUnsafe([Es1], E)
          LEMMA-LIST-CONTAINS-LAST-TO-START
        False ->
          #listContainsUnsafe
                  ( [ #listSwapRemove
                        ( E1
                        , Es1
                        , addOneIfNotNegative(#listFindUnsafe([Es1], Er))
                        )
                    ]
                    , E
                  )
              => #listContainsUnsafe([E1, Es1], E)
            requires E =/= Er andBool E1 =/= Er
          case #listFindUnsafe([Es1], Er) < 0
            True ->
              #listContainsUnsafe
                      ( [ #listSwapRemove
                            ( E1
                            , Es1
                            , #listFindUnsafe([Es1], Er)
                            )
                        ]
                        , E
                      )
                  => #listContainsUnsafe([E1, Es1], E)
                requires E =/= Er andBool E1 =/= Er
              #listContainsUnsafe([E1, Es1 ], E)
                  => #listContainsUnsafe([E1, Es1], E)
                requires E =/= Er andBool E1 =/= Er
              Ok.
            False ->
              #listContainsUnsafe
                      ( [ #listSwapRemove
                            ( E1
                            , Es1
                            , #listFindUnsafe([Es1], Er) +Int 1
                            )
                        ]
                        , E
                      )
                  => #listContainsUnsafe([E1, Es1], E)
                requires E =/= Er
                    andBool E1 =/= Er
                    andBool #listFindUnsafe([Es1], Er) >= 0
              #listContainsUnsafe
                      ( [ E1
                        , #listSwapRemove
                            ( Es1
                            , #listFindUnsafe([Es1], Er)
                            )
                        ]
                        , E
                      )
                  => #listContainsUnsafe([E1, Es1], E)
                requires E =/= Er
                    andBool E1 =/= Er
                    andBool #listFindUnsafe([Es1], Er) >= 0
              case E == E1:
                True -> Ok
                False ->
                  #listContainsUnsafe
                          ( [ #listSwapRemove
                                ( Es1
                                , #listFindUnsafe([Es1], Er)
                                )
                            ]
                            , E
                          )
                      => #listContainsUnsafe([Es1], E)
                    requires E =/= Er
                        andBool E1 =/= Er
                        andBool E1 =/= E
                        andBool #listFindUnsafe([Es1], Er) >= 0
                  induction


------------------------------------------

  LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE
      #listContainsUnsafe([#listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) => false
    requires
      notBool #listContainsUnsafe([Es], E)

  LEMMA-LIST-CONTAINS-POUND-LIST-SWAP-REMOVE-2
      #listContainsUnsafe([E1:Expression, #listSwapRemove(Es:ExpressionCSV, I:Int)], E:Expression) => false
    requires
      notBool #listContainsUnsafe([E1, Es], E)
*/