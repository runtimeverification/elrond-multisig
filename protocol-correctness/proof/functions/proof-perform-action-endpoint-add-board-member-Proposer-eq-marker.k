// timeout = moderate
//@ proof
require "../functions/trusted-perform-action-endpoint-add-board-member-Proposer-eq.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ENDPOINT-ADD-BOARD-MEMBER-PROPOSER-EQ-MARKER
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-BOARD-MEMBER-PROPOSER-EQ
//@ trusted
// module TRUSTED-PERFORM-ACTION-ENDPOINT-ADD-BOARD-MEMBER-PROPOSER-EQ-MARKER
//@ end

  imports EXECUTION-PROOF-HELPERS
  imports INSTRUMENTATION-PROOF
  imports INVARIANT

  claim <T><TT>
          <k> add-board-member-Proposer-eq.k ~> call(performActionEndpoint(ActionId:Usize)) ~> K:K </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> CallerId:Usize
                  _AddressToUserId:Map
              ) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              u(NumProposers:Int),
              (CallerId |-> Proposer
                UserIdToRoleInner:Map
              ) #as UserIdToRole:Map,
              u(Quorum:Int),
              ActionLastIndex:Usize,
              ActionId |-> AddBoardMember(CallerAddress:Address) #as Action:Action
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
              NumUsers,
              UserIdToAddress,
              AddressToUserId,
              u(NumBoardMembers +Int 1),
              u(NumProposers -Int 1),
              CallerId |-> BoardMember
                UserIdToRoleInner:Map,
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
        andBool addressToUserIdInvariant(AddressToUserId)

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
