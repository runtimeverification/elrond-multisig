// breadth = 5
// timeout = long
//@ proof

require "../../1/list/contains/trusted-list-contains-unsafe-change-list-3.k"  //@ Bazel remove
require "../../1/list/contains/trusted-list-contains-unsafe-list-to-map-set-square-bracket-3.k"  //@ Bazel remove

module PROOF-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3
  imports TRUSTED-LIST-CONTAINS-UNSAFE-CHANGE-LIST-3
  imports TRUSTED-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-3

//@ trusted
// require "protocol-correctness/lib/functions/list-elements-are-usize.k"
// require "protocol-correctness/lib/functions/list-to-map-set.k"
// require "protocol-correctness/lib/functions/map-keys-are-kresult.k"
// require "protocol-correctness/lib/functions/map-keys-are-of-type.k"
// require "protocol-correctness/lib/functions/map-values-are-kresult.k"
// require "protocol-correctness/lib/functions/map-values-are-of-type.k"
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// require "protocol-correctness/multisig/lib/language/type-reflection.k"
// require "protocol-correctness/proof/named-lemmas/count-can-sign-list-to-map-set-square-bracket-3.k"
// module TRUSTED-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3
//@ end

  imports BOOL
  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports K-EQUAL-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
  imports LIST-TO-MAP-SET-SYNTAX
  imports MAP
  imports MAP-KEYS-ARE-KRESULT-SYNTAX
  imports MAP-KEYS-ARE-OF-TYPE-SYNTAX
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports MULTISIG-TYPE-REFLECTION-SYNTAX
  imports NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3-SYNTAX

  claim
      lemmaCountCanSignListToMapSetSquareBracket3(
          L1:ExpressionList,
          L2:ExpressionList,
          M:Map,
          E1:Expression,
          E2:Expression,
          EDelete:Expression)
      => .K
    requires true
      andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
          ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
      andBool notBool E1 in_keys(M)
      andBool notBool E2 in_keys(M)
      andBool notBool EDelete in_keys(M)
      andBool mapValuesAreKResult(M)
      andBool mapValuesAreOfType(M, rUserRole)
      andBool mapKeysAreKResult(M)
      andBool mapKeysAreOfType(M, rUsize)
      andBool isKResult(L1)
      andBool listElementsAreUsize(L1)
      andBool isKResult(L2)
      andBool listElementsAreUsize(L2)
    ensures
      countCanSignFunction(L1, M) ==K countCanSignFunction(L2, M)
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule

/*
countCanSignFunction(L1, M) ==K countCanSignFunction(L2, M)
  requires true
    andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
        ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
    andBool notBool E1 in_keys(M)
    andBool notBool E2 in_keys(M)
    andBool notBool EDelete in_keys(M)
    andBool mapValuesAreOfType(M, rUserRole)
    andBool mapKeysAreOfType(M, rUsize)
    andBool isKResult(L1)
    andBool listElementsAreOfType(L1, rUsize)
    andBool isKResult(L2)
    andBool listElementsAreOfType(L2, rUsize)

case M of
  . -> 
    countCanSignFunction(L1, .Map) ==K countCanSignFunction(L2, .Map)
      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool notBool E1 in_keys(.Map)
        andBool notBool E2 in_keys(.Map)
        andBool notBool EDelete in_keys(.Map)
        andBool mapValuesAreOfType(.Map, rUserRole)
        andBool mapKeysAreOfType(.Map, rUsize)
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)
    countCanSignFunction(L1, .Map) ==K countCanSignFunction(L2, .Map)
      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)

    *** TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP-EMPTY

    0 ==K 0
      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)

  K |-> V M1 ->
    countCanSignFunction(L1, K |-> V M1) ==K countCanSignFunction(L2, K |-> V M1)
      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool notBool E1 in_keys(K |-> V M1)
        andBool notBool E2 in_keys(K |-> V M1)
        andBool notBool EDelete in_keys(K |-> V M1)
        andBool mapValuesAreOfType(K |-> V M1, rUserRole)
        andBool mapKeysAreOfType(K |-> V M1, rUsize)
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)
    countCanSignFunction(L1, K |-> V M1) ==K countCanSignFunction(L2, K |-> V M1)
      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool notBool (E1 == K orBool E1 in_keys(M1))
        andBool notBool (E2 == K orBool E2 in_keys(M1))
        andBool notBool (EDelete == K orBool EDelete in_keys(M1))
        andBool isUserRole(V)
        andBool mapValuesAreOfType(M1, rUserRole)
        andBool isUsize(K)
        andBool mapKeysAreOfType(M1, rUsize)
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)
    countCanSignFunction(L1, K |-> V M1) ==K countCanSignFunction(L2, K |-> V M1)
      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool E1 =/= K
        andBool E2 =/= K
        andBool EDelete =/= K
        andBool notBool (E1 in_keys(M1))
        andBool notBool (E2 in_keys(M1))
        andBool notBool (EDelete in_keys(M1))
        andBool isUserRole(V)
        andBool mapValuesAreOfType(M1, rUserRole)
        andBool isUsize(K)
        andBool mapKeysAreOfType(M1, rUsize)
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)

    cast V to UserRole
    cast K to Usize

    *** TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP

    boolToInt(canSignFunctionRole(V) andBool #listContainsSafe(L1, K))
        +Int countCanSignFunction(L1, M1)
      ==K boolToInt(canSignFunctionRole(V) andBool #listContainsSafe(L2, K))
          +Int countCanSignFunction(L2, M1)

      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool E1 =/= K
        andBool E2 =/= K
        andBool EDelete =/= K
        andBool notBool (E1 in_keys(M1))
        andBool notBool (E2 in_keys(M1))
        andBool notBool (EDelete in_keys(M1))
        andBool isUserRole(V)
        andBool mapValuesAreOfType(M1, rUserRole)
        andBool isUsize(K)
        andBool mapKeysAreOfType(M1, rUsize)
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)

    boolToInt(canSignFunctionRole(V) andBool #listContainsUnsafe(L1, K))
        +Int countCanSignFunction(L1, M1)
      ==K boolToInt(canSignFunctionRole(V) andBool #listContainsUnsafe(L2, K))
          +Int countCanSignFunction(L2, M1)

      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool E1 =/= K
        andBool E2 =/= K
        andBool EDelete =/= K
        andBool notBool (E1 in_keys(M1))
        andBool notBool (E2 in_keys(M1))
        andBool notBool (EDelete in_keys(M1))
        andBool isUserRole(V)
        andBool mapValuesAreOfType(M1, rUserRole)
        andBool isUsize(K)
        andBool mapKeysAreOfType(M1, rUsize)
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)

    *** lemmaListContainsUnsafeChangeList3
              ( K, E1, E2, EDelete, L1, L2 )
        #listContainsUnsafe(L1, K) ==K #listContainsUnsafe(L2, K))
          requires true
              andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
                      ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
              andBool E1 =/= K
              andBool E2 =/= K
              andBool EDelete =/= K

    boolToInt(canSignFunctionRole(V) andBool #listContainsUnsafe(L1, K))
        +Int countCanSignFunction(L1, M1)
      ==K boolToInt(canSignFunctionRole(V) andBool #listContainsUnsafe(L1, K))
          +Int countCanSignFunction(L2, M1)

      requires true
        andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
            ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
        andBool E1 =/= K
        andBool E2 =/= K
        andBool EDelete =/= K
        andBool notBool (E1 in_keys(M1))
        andBool notBool (E2 in_keys(M1))
        andBool notBool (EDelete in_keys(M1))
        andBool isUserRole(V)
        andBool mapValuesAreOfType(M1, rUserRole)
        andBool isUsize(K)
        andBool mapKeysAreOfType(M1, rUsize)
        andBool isKResult(L1)
        andBool listElementsAreOfType(L1, rUserRole)
        andBool isKResult(L2)
        andBool listElementsAreOfType(L2, rUserRole)
        andBool #listContainsUnsafe(L1, K) ==K #listContainsUnsafe(L2, K))
    induction(L1, L2, M1)

-----------------------

lemmaListContainsUnsafeChangeList3
          ( K, E1, E2, EDelete, L1, L2 )
#listContainsUnsafe(L1, K) ==K #listContainsUnsafe(L2, K))
  requires true
      andBool listToMapSet(L1)[E2 <- 0][EDelete <- undef]
              ==K listToMapSet(L2)[E1 <- 0][E2 <- 0][EDelete <- undef]
      andBool E1 =/= K
      andBool E2 =/= K
      andBool EDelete =/= K


-----------------------

TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP-EMPTY
countCanSignFunction(L, .Map) ==K 0

-----------------------

TRUSTED-LEMMA-COUNT-CAN-SIGN-MAP
      countCanSignFunction( [ Es:ExpressionCSV ], UserId:Usize |-> Role:UserRole M:Map )
      => boolToInt(canSignFunction(Role) andBool #listContainsSafe([Es], UserId))
        +Int countCanSignFunction([ Es ], M)
    requires
      true
      andBool isKResult(UserId)
      andBool isKResult(Es)
      andBool notBool (UserId in_keys(M))
      andBool listElementsAreOfType([Es], rUserRole)

------------------------

TRUSTED-LEMMA-COUNT-CAN-SIGN-FUNCTION-SECOND-ELEMENT
countCanSignFunction
  ( [ E1:Expression, E2:Expression, Es:ExpressionCSV ]
  , UserIdToRole:Map 
  )
=> countCanSignFunction([E1, Es], UserIdToRole)
  requires
    notBool E2 in_keys(UserIdToRole)



 */