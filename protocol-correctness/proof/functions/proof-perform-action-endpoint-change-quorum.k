// timeout = moderate
//@ proof
require "trusted-perform-action-endpoint-fragment-performs.k"  //@ Bazel remove
require "trusted-perform-action-id-change-quorum.k"  //@ Bazel remove

module PROOF-PERFORM-ACTION-ENDPOINT-CHANGE-QUORUM
  imports TRUSTED-PERFORM-ACTION-ENDPOINT-FRAGMENT-PERFORMS
  imports TRUSTED-PERFORM-ACTION-ID-CHANGE-QUORUM
//@ trusted
// module TRUSTED-PERFORM-ACTION-ENDPOINT-CHANGE-QUORUM
//@ end
    imports INVARIANT

  claim <T><TT>
          <k> call(performActionEndpoint(ActionId:Usize)) ~> K:K </k>
          invariantStateFull(
              NumUsers:Usize,
              UserIdToAddress:Map,
              (CallerAddress |-> CallerId:Usize
                  _AddressToUserId:Map
              ) #as AddressToUserId:Map,
              u(NumBoardMembers:Int),
              NumProposers:Usize,
              (CallerId |-> Role:UserRole
                  _UserIdToRole:Map
              ) #as UserIdToRole:Map,
              u(OldQuorum:Int),
              ActionLastIndex:Usize,
              ActionId |-> ChangeQuorum(u(NewQuorum:Int)) #as Action:Action
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
              u(NumBoardMembers),
              NumProposers,
              UserIdToRole,
              u(NewQuorum),
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
        andBool NewQuorum <=Int NumBoardMembers

        // perform-fragment
        andBool actionSignersInvariant(ActionSigners)
        andBool userIdToRoleInvariant(UserIdToRole)
        andBool (Role ==K BoardMember orBool Role ==K Proposer)
        andBool OldQuorum
                <=Int countCanSignFunction(
                    toExpressionListOrDefault(ActionSigners[ActionId] orDefault [.], [void, .]),
                    UserIdToRole)
    ensures true
    //@ proof
    //@ trusted
    // [trusted]
    //@ end
endmodule
