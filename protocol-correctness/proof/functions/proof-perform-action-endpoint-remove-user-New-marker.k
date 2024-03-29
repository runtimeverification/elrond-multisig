// timeout = moderate
//@ proof
require "../functions/trusted-perform-action-endpoint-remove-user-New.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ENDPOINT-REMOVE-USER-NEW-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-REMOVE-USER-NEW
//@ trusted
// module TRUSTED-PERFORM-ACTION-ENDPOINT-REMOVE-USER-NEW-MARKER
//@ end

    imports INSTRUMENTATION-PROOF
  imports INVARIANT
  imports MAP-KEYS-ARE-BELOW-LIMIT-SYNTAX

  claim <T><TT>
          <k> remove-user-New.k ~> call(performActionEndpoint(ActionId:Usize)) ~> K:K </k>
          invariantStateFull(
              u(NumUsers:Int),
              UserIdToAddress:Map,
              (CallerAddress |-> CallerId:Usize
                  _AddressToUserId:Map
              ) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              u(NumProposers:Int),
              (CallerId |-> Role:UserRole
                  _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex:Usize,
              ActionId |-> RemoveUser(UserAddress:Address) #as Action:Action
                  ActionData:Map,
              ActionSigners:Map,
              CallerAddress:Address,
              Stack:Stack,
              .Map,
              PerformedActions:List
              )
        </TT></T>
      =>
        <T><TT>
          <k> evaluate(void) ~> K:K </k>
          invariantStateFull(
              u(NumUsers +Int 1),
              u(NumUsers +Int 1) |-> UserAddress UserIdToAddress,
              UserAddress |-> u(NumUsers +Int 1) AddressToUserId,
              u(NumBoardMembers),
              u(NumProposers),
              UserIdToRole,
              u(Quorum),
              ActionLastIndex,
              ActionData,
              ActionSigners[ActionId <- undef],
              CallerAddress,
              Stack,
              ?_Variables:Map,
              ListItem(Action) PerformedActions
              )
        </TT></T>
    requires true
        // perform-from-id
        andBool isKResult(Action)
        andBool NumUsers >=Int 0
        // TODO: Perhaps replace with unusedIdsInMapValues(AddressToUserId) +
        // something to map values to keys.
        andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToAddress), expand(expanded))
        andBool mapKeysAreBelowLimitSafe(NumUsers +Int 1, keysMap(UserIdToRole), expand(expanded))
        andBool mapKeysAreOfType(UserIdToAddress, rUsize)
        andBool NumBoardMembers +Int NumProposers >Int 0
        andBool Quorum <=Int NumBoardMembers
        andBool notBool (UserAddress in_keys(AddressToUserId))

        // perform-fragment
        andBool actionSignersInvariant(ActionSigners)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool (Role ==K BoardMember orBool Role ==K Proposer)
        andBool Quorum
                <=Int countCanSignFunction(
                    toExpressionListOrDefault(ActionSigners[ActionId] orDefault [.], [void, .]),
                    UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
