require "protocol-correctness/lib/functions/concretize-expression-list.k"
require "protocol-correctness/proof/main-proof-execute.k"
require "protocol-correctness/proof/invariant/invariant-execute.k"
require "protocol-correctness/proof/malicious-user/malicious-user-execute.k"
require "protocol-correctness/proof/named-lemmas/bool-to-int-sum-and-not.k"
require "protocol-correctness/proof/named-lemmas/count-can-sign-list-to-map-set-square-bracket-3.k"
require "protocol-correctness/proof/named-lemmas/list-contains-unsafe-list-to-map-set-square-bracket.k"
require "protocol-correctness/proof/properties/properties-execute.k"

module CAN-BE-DELETED-EXECUTE-SYNTAX
  imports MAIN-PROOF-EXECUTE-SYNTAX
  imports MALICIOUS-USER-DELETE-ACTIONS-SYNTAX
  imports MALICIOUS-USER-DELETE-INVARIANT-SYNTAX
endmodule

module MALICIOUS-USER-DELETE-ACTIONS-SYNTAX
  imports MAP
  imports PSEUDOCODE-SYNTAX

  imports PROPERTIES-EXECUTE

  syntax KItem ::= allBoardMembersSignForInterspersed(
                      actionId:Usize,
                      maliciousId:Usize,
                      InterspersedActionsData)
  syntax KItem ::= boardMembersSignForInterspersed(
                      actionId:Usize,
                      maliciousId:Usize,
                      userRoles:Map,
                      initialActionSigners:Map,
                      InterspersedActionsData)
  syntax KItem ::= boardMembersSignForInterspersedFreezer(
                      actionId:Usize,
                      maliciousId:Usize,
                      initialActionSigners:Map,
                      InterspersedActionsData)
  syntax KItem ::= #boardMembersSignForInterspersed(
                      actionId:Usize,
                      maliciousId:Usize,
                      key:KItem,
                      value:KItem,
                      userRoles:Map,
                      initialActionSigners:Map,
                      InterspersedActionsData)
  syntax KItem ::= pickOtherBoardMember(
                      /*userIdToRole:*/Map,
                      /*addressToUserId:*/Map,
                      /*userIdToAddress:*/Map,
                      Address)
  syntax KItem ::= pickFirstSignerAvoiding(actionId:Usize, avoidedId:Usize)
  syntax KItem ::= makeConcreteDeleteProposer(deleteActionId:Usize)
  syntax KItem ::= callLemmaBoolToIntSumAndNot(
                      maliciousId:Usize,
                      deleteActionId:Usize)
  syntax KItem ::= callLemmaListContainsUnsafeListToMapSetSquareBracket3(
                      userId:KItem,
                      maliciousId:Usize,
                      oldSigners:ExpressionList,
                      deleteActionId:Usize)
  syntax KItem ::= callLemmaCountCanSignListToMapSetSquareBracket3(
                      oldSigners:ExpressionList,
                      userId:KItem,
                      maliciousId:Usize,
                      deleteActionId:Usize)
  syntax KItem ::= callLemmaCountCanSignListToMapSetSquareBracket3AfterKItem
                      ( actionId:Usize
                      , maliciousId:Usize
                      )
  syntax KItem ::= callLemmaMapKeysAreBelowLimitIgnoresPropertyHandlingActionData
                      ( existing:PropertyHandling
                      , desired:PropertyHandling
                      )
  syntax KItem ::= callLemmaMapKeysAreBelowLimitIgnoresPropertyHandlingActionSigners
                      ( existing:PropertyHandling
                      , desired:PropertyHandling
                      )

  syntax InterspersedActionsData
  syntax K ::= interpersedActionsForUnprocessedUserRoles(
                  InterspersedActionsData, Map
              )  [function]
endmodule

module MALICIOUS-USER-DELETE-ACTIONS
  imports CONCRETIZE-EXPRESSION-LIST-SYNTAX
  imports CONCRETIZE-VALUE-SYNTAX
  imports MALICIOUS-USER-DELETE-ACTIONS-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-ADDITIONAL-SYNTAX
  imports NAMED-LEMMA-BOOL-TO-INT-SUM-AND-NOT-SYNTAX
  imports NAMED-LEMMA-COUNT-CAN-SIGN-LIST-TO-MAP-SET-SQUARE-BRACKET-3-SYNTAX
  imports NAMED-LEMMA-LIST-CONTAINS-UNSAFE-LIST-TO-MAP-SET-SQUARE-BRACKET-SYNTAX

  rule  <k> allBoardMembersSignForInterspersed(
                  ActionId:Usize,
                  MaliciousId:Usize,
                  Data:InterspersedActionsData)
            => boardMembersSignForInterspersed(
                  ActionId, MaliciousId, UserIdToRole, ActionSigners, Data)
        ...</k>
        <user-roles> UserIdToRole:Map </user-roles>
        <action-signers> ActionSigners:Map </action-signers>
    requires notBool (ActionId in_keys(ActionSigners))

  rule  <k> allBoardMembersSignForInterspersed(
                  ActionId:Usize,
                  MaliciousId:Usize,
                  Data:InterspersedActionsData)
            =>  concretizeExpressionList(Signers, 3)
                ~> boardMembersSignForInterspersed(
                      ActionId, MaliciousId, UserIdToRole, ActionSigners, Data)
        ...</k>
        <user-roles> UserId |-> BoardMember UserIdToRole:Map </user-roles>
        <action-signers>
          ( ActionId |-> ([UserId:Usize, _:ExpressionCSV] #as Signers:ExpressionList)
            _ActionSigners:Map
          ) #as ActionSigners:Map
        </action-signers>
    requires
      listToMapSet(Signers)[MaliciousId <- undef]
          ==K listToMapSet([UserId, .])[MaliciousId <- undef]

  rule  <k>
          boardMembersSignForInterspersed
              ( ActionId:Usize, MaliciousId:Usize
              , .Map, _InitialActionSigners:Map
              , _:InterspersedActionsData
              )
          => makeConcreteValue(MaliciousId, rUserRole, UserIdToRole)
              ~> concretizeValue(#listContainsUnsafe(Signers, MaliciousId))        ...
        </k>
        <user-roles>
          UserIdToRole:Map
        </user-roles>
        <action-signers>ActionId |-> Signers:ExpressionList _ActionSigners:Map </action-signers>
    [label(boardMembersSignEmpty)]
  rule  boardMembersSignForInterspersed
                ( ActionId:Usize, MaliciousId:Usize
                , UserIdToRole:Map, InitialActionSigners:Map
                , Data:InterspersedActionsData
                )
        =>  (  lazyMapSelectProperty(UserIdToRole, MEP.AlwaysTrue)
            ~> boardMembersSignForInterspersedFreezer
                  (ActionId, MaliciousId, InitialActionSigners, Data)
            )
    requires true
        andBool notBool (UserIdToRole ==K .Map)
    [label(boardMembersSignIteration)]

  rule
      <k>
        (  mapSelected(Key:KItem, Value:KItem, UserIdToRole:Map)
        ~> boardMembersSignForInterspersedFreezer(
              ActionId:Usize, MaliciousId, ActionSigners:Map, Data:InterspersedActionsData)
        )
        => branchK(
              Key ==K MaliciousId,
              concretizeValue(Value)
                ~> concretizeValue(#listContainsUnsafe(Signers, MaliciousId))
                ~> boardMembersSignForInterspersed(
                    ActionId, MaliciousId, UserIdToRole, ActionSigners, Data),
              #boardMembersSignForInterspersed(
                  ActionId, MaliciousId, Key, Value, UserIdToRole, ActionSigners, Data)
          )
        ...
      </k>
      <action-signers>ActionId |-> Signers:ExpressionList _ActionSigners:Map </action-signers>

  rule 
      <k>
        #boardMembersSignForInterspersed(
            ActionId:Usize,
            MaliciousId:Usize,
            UserId:KItem,
            V:KItem,
            UnprocessedUserIdToRole:Map,
            InitialActionSigners:Map,
            Data:InterspersedActionsData)
        =>  (   cast(V, rUserRole)
            ~>  removeValue
            ~>  concretizeValue(V)
            ~>  branchK(
                  V ==K BoardMember,
                  cast(UserId, rUsize)
                    ~> removeValue
                    ~> concretizeValue(
                          (UserIdToAddress[UserId] orDefault void)
                          ==K (UserIdToAddress[MaliciousId] orDefault void)
                      )
                    ~> makeConcreteValue(UserId, rUserRole, UserIdToRoleCell)
                    ~> makeConcreteValue(UserId, rAddress, UserIdToAddress)
                    ~> signFor(ActionId, UserId)
                    ~> interpersedActionsForUnprocessedUserRoles(Data, UnprocessedUserIdToRole)
                    ~> callLemmaMapKeysAreBelowLimitIgnoresPropertyHandling(usesExpanded, expand(expanded))
                    ~> lemmaBoolToIntSumAndNot(
                          UserIdToRoleCell[MaliciousId] orDefault void ==K BoardMember,
                          #listContainsUnsafe(Signers, MaliciousId)
                      )
                    ~> callLemmaBoolToIntSumAndNot(MaliciousId, ActionId)
                    ~> callLemmaListContainsUnsafeListToMapSetSquareBracket3(
                        UserId, MaliciousId, [SignersLeft], ActionId)
                    ~> callLemmaCountCanSignListToMapSetSquareBracket3(
                        [SignersLeft], UserId, MaliciousId, ActionId)
                    ~> callLemmaOnlyThisSignerDiffsTransitiveRemoveAction
                          ( ActionId
                          , MaliciousId
                          , InitialActionSigners[ActionId <- undef]
                          , ActionSigners
                          )
                    ~> boardMembersSignForInterspersed(
                          ActionId, MaliciousId,
                          UnprocessedUserIdToRole, InitialActionSigners,
                          Data)
                    ,
                  // TODO: THIS SHOULD NOT BE NEEDED.
                  cast(UserId, rUsize)
                    ~> removeValue
                    ~> boardMembersSignForInterspersed(
                          ActionId, MaliciousId,
                          UnprocessedUserIdToRole, InitialActionSigners,
                          Data)
                )
            )
        ...
      </k>
      <user-id-to-address>UserIdToAddress:Map</user-id-to-address>
      <user-roles>UserIdToRoleCell:Map</user-roles>
      <action-signers>
          ActionId |-> [_:Expression, SignersLeft:ExpressionCSV] #as Signers:ExpressionList
          ActionSigners:Map
      </action-signers>

  rule pickOtherBoardMember(UserIdToRole:Map, AddressToUserId:Map, UserIdToAddress:Map, Address:Address)
      =>  makeConcreteValue(Address, rUsize, AddressToUserId)
          ~> makeConcreteValue(AddressToUserId[Address], rAddress, UserIdToAddress)
          ~> makeConcreteValue(AddressToUserId[Address], rUserRole, UserIdToRole)
          ~> #pickOtherBoardMember(UserIdToRole, AddressToUserId[Address])
          ~> withPickedUserMakeConcrete(AddressToUserId, UserIdToAddress, Address)
    requires Address in_keys(AddressToUserId)
  rule pickOtherBoardMember(UserIdToRole:Map, AddressToUserId:Map, _UserIdToAddress:Map, Address:Address)
      => pickBoardMember(UserIdToRole)
    requires notBool Address in_keys(AddressToUserId)

  syntax KItem ::= #pickOtherBoardMember(
                      /*userIdToRole:*/Map,
                      /*userId:*/KItem)
  rule #pickOtherBoardMember(UserIdToRole:Map, UserId:KItem)
    => pickBoardMember(UserIdToRole[UserId <- undef])
    requires UserId in_keys(UserIdToRole)
  rule #pickOtherBoardMember(UserIdToRole:Map, UserId:KItem)
    => pickBoardMember(UserIdToRole)
    requires notBool UserId in_keys(UserIdToRole)

  rule  <k>
          pickFirstSignerAvoiding(ActionId:Usize, AvoidedId:Usize) => FirstSigner
          ...
        </k>
        <action-signers>
          ActionId |-> [FirstSigner:Usize, _:ExpressionCSV] _:Map
        </action-signers>
    requires FirstSigner =/=K AvoidedId

  syntax KItem ::= withPickedUserMakeConcrete(addressToUserId:Map, userIdToAddress:Map, maliciousAddress:Address)
  rule  (  mapSelected(UserId:KItem, _UserRole:KItem, _Remainder:Map) #as Selected:KItem
        ~> withPickedUserMakeConcrete(AddressToUserId:Map, UserIdToAddress:Map, MaliciousAddress:Address)
        )
      =>
        (  withPickedUserMakeConcretePrefix(AddressToUserId, UserIdToAddress, MaliciousAddress, UserId)
        ~> makeConcreteValue(UserId, rAddress, UserIdToAddress)
        ~> Selected
        )
    requires true
      andBool UserId in_keys(UserIdToAddress)

  syntax KItem ::= withPickedUserMakeConcretePrefix(addressToUserId:Map, userIdToAddress:Map, maliciousAddress:Address, userId:KItem)
  rule withPickedUserMakeConcretePrefix(AddressToUserId:Map, UserIdToAddress:Map, MaliciousAddress:Address, UserId:KItem)
      =>
        (  concretizeMapKey(UserId, UserIdToAddress)
        ~> cast(UserIdToAddress[UserId], rAddress)
        ~> removeValue
        ~> concretizeValue(UserIdToAddress[UserId] ==K MaliciousAddress)
        ~> concretizeValue(UserIdToAddress[UserId])
        ~> makeConcreteValue(UserIdToAddress[UserId], rUsize, AddressToUserId)
        ~> concretizeMapKey(UserIdToAddress[UserId], AddressToUserId)
        )

  rule  <k>
          makeConcreteDeleteProposer(DeleteActionId:Usize)
          =>  concretizeValue(UserId)
              ~> makeConcreteValue(UserId, rUserRole, UserIdToRole)
          ...
        </k>
        <user-roles>UserIdToRole:Map</user-roles>
        <action-signers>
          DeleteActionId |-> [UserId:Usize, .] _ActionSigners:Map
        </action-signers>

  rule  <k>
          callLemmaBoolToIntSumAndNot(MaliciousId:Usize, DeleteActionId:Usize)
          =>  lemmaBoolToIntSumAndNot(
                  MaliciousRole ==K BoardMember,
                  #listContainsUnsafe(Signers, MaliciousId)
              )
          ...
        </k>
        <user-roles>MaliciousId |-> MaliciousRole:UserRole _UserIdToRole:Map</user-roles>
        <action-signers>
          DeleteActionId |-> Signers:ExpressionList _ActionSigners:Map
        </action-signers>

  rule  <k>
          callLemmaListContainsUnsafeListToMapSetSquareBracket3(
              UserId:Usize, MaliciousId:Usize,
              OldSigners:ExpressionList,
              DeleteActionId:Usize)
            => lemmaListContainsUnsafeListToMapSetSquareBracket3(
                UserId,
                [NewSigners],
                DeleteFirstSignerId,
                MaliciousId,
                OldSigners)
          ...
        </k>
        <action-signers>
          DeleteActionId |-> [DeleteFirstSignerId:Usize, NewSigners:ExpressionCSV]
          _ActionSigners:Map
        </action-signers>

  rule  <k>
          callLemmaCountCanSignListToMapSetSquareBracket3(
              OldSigners:ExpressionList,
              UserId:Usize,
              MaliciousId:Usize,
              DeleteActionId:Usize)
          => lemmaCountCanSignListToMapSetSquareBracket3(
              [NewSigners],
              OldSigners,
              UserIdToRole
                [DeleteFirstSignerId <- undef]
                [MaliciousId <- undef]
                [UserId <- undef],
              UserId,
              DeleteFirstSignerId,
              MaliciousId)
          ...
        </k>
        <user-roles>UserIdToRole:Map</user-roles>
        <action-signers>
          DeleteActionId |-> [DeleteFirstSignerId:Usize, NewSigners:ExpressionCSV]
          _ActionSigners:Map
        </action-signers>

  // rule
  //     <k>
  //       callLemmaCountCanSignListToMapSetSquareBracket3
  //           ( ActionId:Usize
  //           , OldSigners:ExpressionList
  //           , FirstSignerId:Usize
  //           , MaliciousId:Usize
  //           )
  //       => lemmaCountCanSignListToMapSetSquareBracket3
  //           ( OldSigners
  //           , NewSigners
  //           , UserIdToRole[FirstSignerId <- undef][MaliciousId <- undef]
  //           , FirstSignerId
  //           , FirstSignerId
  //           , MaliciousId
  //           )
  //     </k>
  //     <action-signers>
  //       ActionId |-> NewSigners:ExpressionList _ActionSigners:Map
  //     </action-signers>
  //     <user-roles>
  //       UserIdToRole:Map
  //     </user-roles>

  rule
      <k>
        ( callLemmaCountCanSignListToMapSetSquareBracket3AfterKItem
            ( ActionId:Usize
            , MaliciousId:Usize
            )
        ~> Next:KItem
        ) 
        =>
        ( Next
        ~> callLemmaCountCanSignListToMapSetSquareBracket3
            ( removeFirstOrDefault
                ( toExpressionListOrDefault
                    ( ActionSigners[ActionId] orDefault void
                    , [.]
                    )
                , [.]
                )
            , toUsizeOrDefault
                ( firstOrDefault
                  ( toExpressionListOrDefault
                      ( ActionSigners[ActionId] orDefault void
                      , [.]
                      )
                  , void
                  )
                , u(0)
                )
            , MaliciousId
            , ActionId
            )
        )
        ...
      </k>
      <action-signers>
        ActionSigners:Map
      </action-signers>

  rule
      <k>
        callLemmaMapKeysAreBelowLimitIgnoresPropertyHandlingActionData
            ( Existing:PropertyHandling
            , Desired:PropertyHandling
            )
        => lemmaMapKeysAreBelowLimitIgnoresPropertyHandling
            ( ActionLastIndex +Int 1
            , ActionData
            , Existing
            , Desired
            )
        ...
      </k>
      <action-last-index>
        u(ActionLastIndex:Int)
      </action-last-index>
      <action-data>
        ActionData:Map
      </action-data>

  rule
      <k>
        callLemmaMapKeysAreBelowLimitIgnoresPropertyHandlingActionSigners
            ( Existing:PropertyHandling
            , Desired:PropertyHandling
            )
        => lemmaMapKeysAreBelowLimitIgnoresPropertyHandling
            ( ActionLastIndex +Int 1
            , ActionSigners
            , Existing
            , Desired
            )
        ...
      </k>
      <action-last-index>
        u(ActionLastIndex:Int)
      </action-last-index>
      <action-signers>
        ActionSigners:Map
      </action-signers>

endmodule

module MALICIOUS-USER-DELETE-INVARIANT-SYNTAX
  imports MAP
  imports PSEUDOCODE-SYNTAX
  imports EXECUTION-PROOF-HELPERS

  syntax Bool ::= maliciousDeleteInvariant(
            /*maliciousAddress:*/Address,
            /*numUsers:*/Usize,
            /*currentUserIdToAddress:*/Map,
            /*currentAddressToUserId:*/Map,
            /*numBoardMembers:*/Usize,
            /*numProposers:*/Usize,
            /*userRoles:*/Map,
            /*quorum:*/Usize,
            /*actionLastIndex:*/Usize,
            /*actionData:*/Map,
            /*actionSigners:*/Map,
            PropertyHandling)
      [function, functional]
endmodule

module MALICIOUS-USER-DELETE-INVARIANT
  imports MALICIOUS-USER-DELETE-INVARIANT-SYNTAX

  imports INVARIANT
  imports MALICIOUS-USER-INVARIANT-FUNCTIONS
  imports MAP-EXECUTE-SYNTAX

  rule  maliciousDeleteInvariant(
            MaliciousAddress:Address,
            NumUsers:Usize,
            UserIdToAddress:Map,
            AddressToUserId:Map,
            NumBoardMembers:Usize,
            NumProposers:Usize,
            UserIdToRole:Map,
            u(Quorum:Int),
            ActionLastIndex:Usize,
            ActionData:Map,
            ActionSigners:Map,
            Handling:PropertyHandling)
      => true
        andBool baseInvariant(
            NumUsers,
            UserIdToAddress,
            AddressToUserId,
            NumBoardMembers,
            NumProposers,
            UserIdToRole,
            u(Quorum),
            ActionLastIndex,
            ActionData,
            ActionSigners,
            Handling)
        // andBool onlyThisSigner(AddressToUserId, MaliciousAddress, ActionSigners)
        andBool Quorum >=Int 2
        andBool mapCount(
                    UserIdToRole[AddressToUserId[MaliciousAddress] orDefault u(0) <- undef],
                    MEP.IsValue(BoardMember)
                ) >Int 0
        andBool MaliciousAddress in_keys(AddressToUserId)
        andBool noQuorumCanBeFilledBy(
                    Quorum,
                    toUsizeOrDefault(
                        AddressToUserId[MaliciousAddress] orDefault void,
                        u(0)
                    ),
                    ActionSigners,
                    UserIdToRole)

endmodule

module CAN-BE-DELETED-INTERSPERSED-ACTIONS-SYNTAX
  imports BASE-TYPES-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX

  syntax InterspersedActionsData ::= runExternalCallsFromUserData(
                        maliciousAddress:Address,
                        actionIndex:Usize,
                        count:Int,
                        MaliciousUserLemmas)
endmodule

module CAN-BE-DELETED-INTERSPERSED-ACTIONS
  imports CAN-BE-DELETED-INTERSPERSED-ACTIONS-SYNTAX
  imports MALICIOUS-USER-DELETE-ACTIONS-SYNTAX
  imports MALICIOUS-USER-EXTERNAL-CALLS-SYNTAX

  rule  interpersedActionsForUnprocessedUserRoles(
            runExternalCallsFromUserData(
                MaliciousAddress:Address,
                ActionIndex:Usize,
                Count:Int,
                Lemmas:MaliciousUserLemmas
            ),
            UnprocessedUserRoles:Map
        )
        => runExternalCallsFromUser(
              MaliciousAddress,
              ActionIndex,
              Count,
              UnprocessedUserRoles,
              Lemmas)
endmodule

module CAN-BE-DELETED-EXECUTE
  imports CAN-BE-DELETED-EXECUTE-SYNTAX
  imports CAN-BE-DELETED-INTERSPERSED-ACTIONS
  imports MALICIOUS-USER-DELETE-INVARIANT
  imports MALICIOUS-USER-DELETE-ACTIONS
  imports MALICIOUS-USER-EXECUTE
  imports MALICIOUS-USER-EXTERNAL-CALLS
  imports MALICIOUS-USER-INVARIANT
  imports MAIN-PROOF-EXECUTE
  imports ONLY-THIS-SIGNER-DIFFS

  // TODO: Not sure why the Haskell backend does not evaluate this.
  // Remove when it does.
  rule address(A1) ==K address(A2) => A1 ==K A2
endmodule
