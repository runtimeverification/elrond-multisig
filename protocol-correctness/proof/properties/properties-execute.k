require "protocol-correctness/proof/main-proof-execute.k"
require "protocol-correctness/proof/invariant/invariant-execute.k"
require "protocol-correctness/proof/map/map-execute.k"

module PROPERTIES-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-SYNTAX
endmodule

module PROPERTIES-EXECUTE
  imports MAIN-PROOF-EXECUTE
  imports INVARIANT-EXECUTE
  imports MAP-EXECUTE
  imports CONCRETIZE-VALUE-SYNTAX

  syntax KItem ::= allBoardMembersSignFor(actionId:Usize)
  syntax KItem ::= boardMembersSignFor(actionId:Usize, userRoles:Map)
  syntax KItem ::= boardMembersSignForFreezer(actionId:Usize)
  syntax KItem ::= #boardMembersSignFor(
                      actionId:Usize,
                      key:KItem,
                      value:KItem,
                      userRoles:Map)
  syntax KItem ::= signFor(actionId:Usize, userId:KItem)
  syntax KItem ::= #signFor(actionId:Usize, userId:KItem)
  syntax KItem ::= lazyCastMapValue(key:KItem, Map, ReflectionType)
  syntax KItem ::= castMapValue(key:KItem, Map, ReflectionType)  [function, functional]
  syntax KItem ::= castValue(value:KItem, ReflectionType)
  syntax KItem ::= "normalizeActionSigners"

  rule  <k> allBoardMembersSignFor(ActionId:Usize)
            => boardMembersSignFor(ActionId, UserIdToRole)
        ...</k>
        <user-roles> UserIdToRole:Map </user-roles>
        <action-signers> ActionSigners:Map </action-signers>
    requires notBool (ActionId in_keys(ActionSigners))

  rule  <k> allBoardMembersSignFor(ActionId:Usize)
            => boardMembersSignFor(ActionId, UserIdToRole)
        ...</k>
        <user-roles> UserId |-> BoardMember UserIdToRole:Map </user-roles>
        <action-signers> ActionId |-> [UserId:Usize, .] _ActionSigners:Map </action-signers>

  rule  boardMembersSignFor(_ActionId:Usize, .Map) => .K
  rule  boardMembersSignFor(ActionId:Usize, UserIdToRole:Map)
        =>  (  lazyMapSelectProperty(UserIdToRole, MEP.AlwaysTrue)
            ~> boardMembersSignForFreezer(ActionId)
            )
    requires notBool (UserIdToRole ==K .Map)

  rule  <k> (  mapSelected(Key:KItem, Value:KItem, UserIdToRole:Map)
            ~> boardMembersSignForFreezer(ActionId:Usize)
            )
            =>  (  makeConcreteValue(Key, rUserRole, FullUserIdToRole)
                ~> #boardMembersSignFor(ActionId, Key, Value, UserIdToRole)
                )
        ...</k>
        <user-roles> FullUserIdToRole:Map </user-roles>

  rule  #boardMembersSignFor(
            ActionId:Usize,
            UserId:KItem,
            V:KItem,
            UserIdToRole:Map)
        =>  (   cast(V, rUserRole)
            ~>  removeValue
            ~>  concretizeValue(V)
            ~>  branchK(
                  V ==K BoardMember,
                  cast(UserId, rUsize)
                    ~> removeValue
                    ~> signFor(ActionId, UserId)
                    ~> boardMembersSignFor(ActionId, UserIdToRole),
                  boardMembersSignFor(ActionId, UserIdToRole)
                )
            )

  rule  <k> signFor(ActionId:Usize, UserId:KItem)
            =>  (  makeConcreteValue(UserId, rAddress, UserIdToAddress)
                ~> #signFor(ActionId, UserId)
                )
        ...</k>
        <user-id-to-address> UserIdToAddress:Map </user-id-to-address>

  rule  <k> #signFor(ActionId:Usize, UserId:KItem)
            => runExternalCall(from Address run sign(ActionId);)
        ...</k>
        <user-id-to-address> UserId |-> Address:Address _UserIdToAddress:Map </user-id-to-address>

  rule lazyCastMapValue(Key:KItem, M:Map, Type:ReflectionType)
      => castMapValue(Key, M, Type)

  rule castMapValue(Key:KItem, M:Map, _Type:ReflectionType) => stuck
    requires notBool Key in_keys(M)
  rule castMapValue(Key:KItem, (K:KItem |-> Value:KItem) _:Map, Type:ReflectionType)
      => castValue(Value, Type)
    requires Key ==K K
    [simplification]
  rule castValue(Value:KItem, Type:ReflectionType)
      => cast(Value, Type) ~> removeValue

  syntax KItem ::= pickBoardMember(Map)

  rule pickBoardMember(M:Map)
      => branchK(
          mapCount(M, MEP.IsValue(BoardMember)) >Int 0,
          lazyMapSelectProperty(M, MEP.IsValue(BoardMember)),
          stuck
        )

  syntax KItem ::= pickBoardMemberOrProposer(Map)

  rule pickBoardMemberOrProposer(M:Map)
      => splitBoolean(mapCount(M, MEP.IsValue(BoardMember)) >Int 0)
        ~> branchK(
            mapCount(M, MEP.IsValue(BoardMember)) >Int 0,
            lazyMapSelectProperty(M, MEP.IsValue(BoardMember)),
            splitBoolean(mapCount(M, MEP.IsValue(Proposer)) >Int 0)
              ~> branchK(
                  mapCount(M, MEP.IsValue(Proposer)) >Int 0,
                  lazyMapSelectProperty(M, MEP.IsValue(Proposer)),
                  stuck
              )
        )

  syntax KItem ::= withPickedUserCall(EndpointCall)

  rule  <k>
          ( mapSelected(UserId:KItem, _UserRole:KItem, _Remainder:Map)
            => nullableMapLookup(UserId, UserIdToAddress, rAddress)
          )
          ~> withPickedUserCall(_:EndpointCall)
        ...</k>
        <user-id-to-address> UserIdToAddress:Map </user-id-to-address>
  rule  (  Address:Address
        ~> withPickedUserCall(Call:EndpointCall)
        )
      => concretizeValue(Address) ~> runExternalCall(from Address run Call;)

  rule  <k> normalizeActionSigners
            =>  branchK(
                    NumBoardMembers >Int 0,
                    makeConcreteValue(ActionLastIndex, rExpressionList, ActionSigners),
                    .K)
        ... </k>
        <num-board-members>u(NumBoardMembers:Int)</num-board-members>
        <action-last-index>ActionLastIndex:Usize</action-last-index>
        <action-signers> ActionSigners:Map </action-signers>

  ////////////////////////////////////////

// TODO: Move to the execution module.

  // TODO: Make this the main invariant
  // syntax Bool ::= newUserIdToRoleInvariant(userIdToRole:Map, userIdToAddress:Map)
  //   [function, functional]

  // rule newUserIdToRoleInvariant(.Map, _:Map) => true

  // rule newUserIdToRoleInvariant(K:KItem |-> V:KItem UserIdToRole:Map, UserIdToAddress:Map)
  //   => true
  //     andBool valueOfType(V, rUserRole)  // mapValuesAreOfType(UserIdToRole, rUserRole)
  //     andBool isKResult(V)  // mapValuesAreKResult(UserIdToRole)
  //     andBool valueIsNotEmpty(V, rUserRole)  // mapValuesAreNotEmpty(UserIdToRole, rUserRole)
  //     andBool valueOfType(K, rUsize)  // mapKeysAreOfType(UserIdToRole, rUsize)
  //     andBool isKResult(K)  // mapKeysAreKResult(UserIdToRole)
  //     andBool K in_keys(UserIdToAddress)  // allKeysBecomeKeys(UserIdToRole, UserIdToAddress)

  //     andBool newUserIdToRoleInvariant(UserIdToRole, UserIdToAddress)
  //   [simplification]

  // syntax Bool ::= userIdToAddressInvariant(userIdToAddress:Map, addressToUserId:Map)
  //   [function, functional]

  // rule userIdToAddressInvariant(.Map, _:Map) => true

  // rule userIdToAddressInvariant(K:KItem |-> V:KItem UserIdToAddress:Map, AddressToUserId:Map)
  //   => true
  //     andBool valueOfType(V, rAddress)  // mapValuesAreOfType(UserIdToAddress, rAddress)
  //     andBool isKResult(V)  // mapValuesAreKResult(UserIdToAddress)
  //     andBool valueIsNotEmpty(V, rAddress)  // mapValuesAreNotEmpty(UserIdToAddress, rAddress)
  //     andBool V in_keys(AddressToUserId) andBool AddressToUserId[V] ==K K  // mapsAreReverseHalf(UserIdToAddress, AddressToUserId)

  //     andBool userIdToAddressInvariant(UserIdToAddress, AddressToUserId)
  //   [simplification]

  rule A:Int <=Int countCanSignFunction(L:ExpressionList, K:KItem |-> BoardMember M:Map) => true
    requires true
        andBool A <=Int mapCount(M, MEP.IsValue(BoardMember)) +Int 1
        andBool mapCount(M, MEP.IsValue(BoardMember)) +Int 1
                ==K countCanSignFunction(L:ExpressionList, K |-> BoardMember M:Map)
    [simplification]

endmodule
