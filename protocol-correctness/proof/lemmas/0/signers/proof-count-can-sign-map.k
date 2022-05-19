// breadth = 10
// timeout = moderate
//@ proof
module PROOF-COUNT-CAN-SIGN-MAP
//@ trusted
// require "protocol-correctness/lib/functions/bool-to-int.k"
// require "protocol-correctness/lib/functions/list-contains.k"
// require "protocol-correctness/lib/functions/list-elements-are-usize.k"
// require "protocol-correctness/lib/functions/map-values-are-kresult.k"
// require "protocol-correctness/lib/functions/map-values-are-of-type.k"
// require "protocol-correctness/multisig/lib/functions/can-sign-function.k"
// require "protocol-correctness/multisig/lib/functions/count-can-sign-function.k"
// require "protocol-correctness/multisig/lib/language/type-reflection.k"
// require "protocol-correctness/proof/named-lemmas/count-can-sign-map.k"
// module TRUSTED-COUNT-CAN-SIGN-MAP
//@ end

  imports BOOL-TO-INT-SYNTAX
  imports CAN-SIGN-FUNCTION-SYNTAX
  imports COUNT-CAN-SIGN-FUNCTION-SYNTAX
  imports K-EQUAL-SYNTAX
  imports LIST-CONTAINS-SYNTAX
  imports LIST-ELEMENTS-ARE-USIZE-SYNTAX
  imports MAP-VALUES-ARE-KRESULT-SYNTAX
  imports MAP-VALUES-ARE-OF-TYPE-SYNTAX
  imports MULTISIG-TYPE-REFLECTION-SYNTAX
  imports NAMED-LEMMA-COUNT-CAN-SIGN-MAP-SYNTAX

  claim lemmaCountCanSignMap(
            Es:ExpressionCSV,
            UserId:Usize,
            Role:UserRole,
            UserIdToRole:Map,
            Delta:Int
        )
      => .K
    requires true
      andBool isKResult(UserId)
      andBool isKResultExpressionCSV(Es)
      andBool notBool (UserId in_keys(UserIdToRole))
      andBool mapValuesAreKResult(UserIdToRole)
      andBool mapValuesAreOfType(UserIdToRole, rUserRole)
      andBool listElementsAreUsize([Es])
    ensures
      (countCanSignFunction( [ Es:ExpressionCSV ], UserId:Usize |-> Role:UserRole UserIdToRole:Map )
      +Int Delta
      )
      ==K ( boolToInt(canSignFunction(Role) andBool #listContainsSafe([Es], UserId))
          +Int countCanSignFunction([ Es ], UserIdToRole)
          +Int Delta
          )
    //@ proof
    //@ trusted
    // [trusted]
    //@ end

endmodule
/*
rule countCanSignFunction(Es, UserId |-> Role:UserRole M:Map)
    =>  boolToInt(canSignFunction(Role) andBool #listContainsSafe(Es, UserId))
        +Int countCanSignFunction(Es, M)
  requires true
    andBool isKResult(UserID)
    andBool isKResult(Es)
    andBool notBool UserId in_keys(M)

rule countCanSignFunction(Es, UserId |-> Role M)
    =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(Es, UserId))
        +Int countCanSignFunction(Es, M)
  requires true
    andBool isKResult(UserID)
    andBool isKResult(Es)
    andBool notBool UserId in_keys(M)

case es of
  . ->
    rule countCanSignFunction(., UserId |-> Role M)
        =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(., UserId))
            +Int countCanSignFunction(., M)
      requires true
        andBool isKResult(UserID)
        andBool isKResult(.)
        andBool notBool UserId in_keys(M)
    rule 0
        =>  boolToInt(canSignFunction(Role) andBool false)
            +Int 0
      requires true
        andBool isKResult(UserID)
        andBool notBool UserId in_keys(M)
    rule 0 => boolToInt(false)
      requires true
        andBool isKResult(UserID)
        andBool notBool UserId in_keys(M)
    ok.
  E <> Es1 ->
    cast e to USize
    rule countCanSignFunction(E <> Es1, UserId |-> Role M)
        =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(E <> Es1, UserId))
            +Int countCanSignFunction(E <> Es1, M)
      requires true
        andBool isKResult(UserID)
        andBool isKResult(E <> Es1)
        andBool notBool UserId in_keys(M)
    rule countCanSignFunction(E <> Es1, UserId |-> Role M)
        =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(E <> Es1, UserId))
            +Int countCanSignFunction(E <> Es1, M)
      requires true
        andBool isKResult(UserID)
        andBool isKResult(E)
        andBool isKResult(Es1)
        andBool notBool UserId in_keys(M)
    case E == UserId of
      True ->
        rule countCanSignFunction(E <> Es1, E |-> Role M)
            =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(E <> Es1, E))
                +Int countCanSignFunction(E <> Es1, M)
          requires true
            andBool isKResult(E)
            andBool isKResult(E)
            andBool isKResult(Es1)
            andBool notBool E in_keys(M)
        rule countCanSignFunction(E <> Es1, E |-> Role M)
            =>  boolToInt(canSignFunction(Role) andBool true)
                +Int countCanSignFunction(Es1, M)
          requires true
            andBool isKResult(E)
            andBool isKResult(Es1)
            andBool notBool E in_keys(M)
        rule countCanSignFunction(E <> Es1, E |-> Role M)
            =>  boolToInt(canSignFunction(Role)) +Int countCanSignFunction(Es1, M)
          requires true
            andBool isKResult(E)
            andBool isKResult(Es1)
            andBool notBool E in_keys(M)
        case Role of
          None ->
            rule countCanSignFunction(E <> Es1, E |-> None:UserRole M)
                =>  boolToInt(canSignFunction(None)) +Int countCanSignFunction(Es1, M)
              requires true
                andBool isKResult(E)
                andBool isKResult(Es1)
                andBool notBool E in_keys(M)
            rule countCanSignFunction(Es1, M)
                =>  boolToInt(false) +Int countCanSignFunction(Es1, M)
              requires true
                andBool isKResult(E)
                andBool isKResult(Es1)
                andBool notBool E in_keys(M)
            ok.
          Proposer ->
            rule countCanSignFunction(E <> Es1, E |-> Proposer:UserRole M)
                =>  boolToInt(canSignFunction(Proposer)) +Int countCanSignFunction(Es1, M)
              requires true
                andBool isKResult(E)
                andBool isKResult(Es1)
                andBool notBool E in_keys(M)
            rule countCanSignFunction(Es1, M)
                =>  boolToInt(false) +Int countCanSignFunction(Es1, M)
              requires true
                andBool isKResult(E)
                andBool isKResult(Es1)
                andBool notBool E in_keys(M)
            ok
          BoardMember ->
            rule countCanSignFunction(E <> Es1, E |-> BoardMember:UserRole M)
                =>  boolToInt(canSignFunction(BoardMember)) +Int countCanSignFunction(Es1, M)
              requires true
                andBool isKResult(E)
                andBool isKResult(Es1)
                andBool notBool E in_keys(M)
            rule 1 + countCanSignFunction(Es1, M)
                =>  boolToInt(true) +Int countCanSignFunction(Es1, M)
              requires true
                andBool isKResult(E)
                andBool isKResult(Es1)
                andBool notBool E in_keys(M)
      False ->
        rule countCanSignFunction(E <> Es1, UserId |-> Role M)
            =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(E <> Es1, UserId))
                +Int countCanSignFunction(E <> Es1, M)
          requires true
            andBool isKResult(UserID)
            andBool isKResult(E)
            andBool isKResult(Es1)
            andBool notBool UserId in_keys(M)
            andBool E =/= UserId
        rule countCanSignFunction(E <> Es1, UserId |-> Role M)
            =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(Es1, UserId))
                +Int countCanSignFunction(E <> Es1, M)
          requires true
            andBool isKResult(UserID)
            andBool isKResult(E)
            andBool isKResult(Es1)
            andBool notBool UserId in_keys(M)
            andBool E =/= UserId
        case E in M of
          . ->
            rule countCanSignFunction(Es1, UserId |-> Role M)
                =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(Es1, UserId))
                    +Int countCanSignFunction(Es1, M)
              requires true
                andBool isKResult(UserID)
                andBool isKResult(E)
                andBool isKResult(Es1)
                andBool notBool UserId in_keys(M)
                andBool E =/= UserId
                andBool notBool E in M
            induction(Es1, UserId, Role, M)
          M1 E |-> V ->
            rule countCanSignFunction(E <> Es1, UserId |-> Role E |-> V M1)
                =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(Es1, UserId))
                    +Int countCanSignFunction(E <> Es1, E |-> V M1)
              requires true
                andBool isKResult(UserID)
                andBool isKResult(E)
                andBool isKResult(Es1)
                andBool notBool UserId in_keys(E |-> V M1)
                andBool E =/= UserId
            case $canSignFunction(V) of
              false ->
                rule countCanSignFunction(E <> Es1, UserId |-> Role E |-> V M1)
                    =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(Es1, UserId))
                        +Int countCanSignFunction(E <> Es1, E |-> V M1)
                  requires true
                    andBool isKResult(UserID)
                    andBool isKResult(E)
                    andBool isKResult(Es1)
                    andBool notBool UserId in_keys(E |-> V M1)
                    andBool E =/= UserId
                    andBool notBool canSignFunction(V)
                rule countCanSignFunction(Es1, UserId |-> Role E |-> V M1)
                    =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(Es1, UserId))
                        +Int countCanSignFunction(Es1, E |-> V M1)
                  requires true
                    andBool isKResult(UserID)
                    andBool isKResult(E)
                    andBool isKResult(Es1)
                    andBool notBool UserId in_keys(E |-> V M1)
                    andBool E =/= UserId
                    andBool notBool canSignFunction(V)
                induction(Es1, UserId, Role, M)
              true ->
                rule countCanSignFunction(E <> Es1, UserId |-> Role E |-> V M1)
                    =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(Es1, UserId))
                        +Int countCanSignFunction(E <> Es1, E |-> V M1)
                  requires true
                    andBool isKResult(UserID)
                    andBool isKResult(E)
                    andBool isKResult(Es1)
                    andBool notBool UserId in_keys(E |-> V M1)
                    andBool E =/= UserId
                    andBool canSignFunction(V)
                rule 1 + countCanSignFunction(Es1, UserId |-> Role M1)
                    =>  boolToInt(canSignFunction(Role) andBool #listContainsUnsafe(Es1, UserId))
                        +Int countCanSignFunction(Es1, M1)
                        +Int 1
                  requires true
                    andBool isKResult(UserID)
                    andBool isKResult(E)
                    andBool isKResult(Es1)
                    andBool notBool UserId in_keys(E |-> V M1)
                    andBool E =/= UserId
                    andBool canSignFunction(V)
                induction(Es1, UserId, Role, M1)
*/
