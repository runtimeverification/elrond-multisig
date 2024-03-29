// timeout = moderate
//@ proof
require "../functions/trusted-perform-action-endpoint-remove-user-BoardMember-too-few-eq.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ENDPOINT-REMOVE-USER-BOARDMEMBER-TOO-FEW-EQ-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-REMOVE-USER-BOARDMEMBER-TOO-FEW-EQ
//@ trusted
// module TRUSTED-PERFORM-ACTION-ENDPOINT-REMOVE-USER-BOARDMEMBER-TOO-FEW-EQ-MARKER
//@ end

    imports INSTRUMENTATION-PROOF
  imports INVARIANT

  claim <T><TT>
          <k> remove-user-BoardMember-too-few-eq.k ~> call(performActionEndpoint(ActionId:Usize)) ~> K:K </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> CallerId:Usize
                  _AddressToUserId:Map
              ) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              u(NumProposers:Int),
              (CallerId |-> BoardMember
                  _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex:Usize,
              ActionId |-> RemoveUser(CallerAddress:Address) #as Action:Action
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
          <k> error ~> K:K </k>
          invariantStateFull(
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              u(NumBoardMembers),
              u(NumProposers),
              UserIdToRole,
              u(Quorum),
              ActionLastIndex,
              ActionId |-> Action ActionData,
              ActionSigners,
              CallerAddress,
              Stack,
              ?_Variables:Map,
              PerformedActions
              )
        </TT></T>
    requires true
        // perform-from-id
        andBool isKResult(Action)
        andBool addressToUserIdInvariant(AddressToUserId)
        andBool (false
            orBool NumBoardMembers +Int NumProposers ==Int 1
            orBool Quorum ==Int NumBoardMembers
        )

        // perform-fragment
        andBool actionSignersInvariant(ActionSigners)
        andBool userIdToRoleInvariant(UserIdToRole)
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
